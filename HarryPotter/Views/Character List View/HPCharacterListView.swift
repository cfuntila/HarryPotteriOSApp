//
//  HPCharacterListView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import UIKit


/// CharacterListViewDelegate Delegate Protocol
protocol HPCharacterListViewDelegate: AnyObject {
    func didSelectCharacter(_ character: HPCharacterData)
}

/// View that shows list of characters and spinner
final class HPCharacterListView: UIView {
    
    //MARK: - Properties
    
    private let viewModel = HPCharacterListViewViewModel()
    
    public weak var delegate: HPCharacterListViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a character"
        return searchBar
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        // Create a UICollectionViewFlowLayout with vertical scrolling and custom section insets.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        
        // Create the main UICollectionView instance.
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            
        // Initially hide and set the alpha to 0 for later animation.
        collectionView.isHidden = true
        collectionView.alpha = 0
        
        // Register custom UICollectionViewCell and a supplementary view for loading.
        collectionView.registerCells()
        
        return collectionView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(searchBar, collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        
        searchBar.delegate = self
        
        viewModel.delegate = self
        viewModel.fetchCharacters()
        
        setUpCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    
    private func addConstraints() {
        spinner.center(inView: self)
        spinner.setDimensions(width: 100, height: 100)
        searchBar.anchor(
            top: topAnchor,
            bottom: collectionView.topAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingBottom: 10
        )
        collectionView.anchor(
            top: searchBar.bottomAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 10
        )
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }

}

//MARK: - HPCharacterListViewViewModelDelegate

extension HPCharacterListView: HPCharacterListViewViewModelDelegate {
    func didSelectCharacter(_ character: HPCharacterData) {
        delegate?.didSelectCharacter(character)        
    }
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreCharacters(with paths: [IndexPath], characters: [HPCharacterData]) {
        //TODO: - Fix
        collectionView.reloadData()
    }
    
    func didFilterForCharacters() {
        collectionView.reloadData()
    }
}


//MARK: - UICollectionView Extension
private extension UICollectionView {
    // Register custom cell and supplementary view identifiers.
    func registerCells() {
        // Register the custom character cell for reuse.
        register(HPCollectionViewCell.self, forCellWithReuseIdentifier: HPCollectionViewCell.identifier)
        
        // Register the custom footer loading supplementary view.
        register(
            HPFooterLoadingCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: HPFooterLoadingCollectionReusableView.identifier
        )
    }
}

extension HPCharacterListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        viewModel.fetchCharacters(withName: query)
    }
    
    
}
