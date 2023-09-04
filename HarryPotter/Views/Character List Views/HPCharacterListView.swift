//
//  HPCharacterListView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import UIKit


/// CharacterListView Delegate Protocol
protocol HPCharacterListViewDelegate: AnyObject {
    func didSelectCharacter(_ character: HPCharacterData)
}

/// View that shows list of characters and spinner
final class HPCharacterListView: UIView {
    
    //MARK: - Properties
    
    private let viewModel = HPCharacterListViewViewModel()
    
    public weak var delegate: HPCharacterListViewDelegate?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(HPCharacterCollectionViewCell.self, forCellWithReuseIdentifier: HPCharacterCollectionViewCell.identifier)
        collectionView.register(HPFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HPFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews(collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        
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
        collectionView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor)
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
}
