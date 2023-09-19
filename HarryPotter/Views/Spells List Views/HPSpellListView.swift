//
//  HPSpellListView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import UIKit

final class HPSpellListView: UIView {
    
    //MARK: - Properties
    
    private let viewModel = HPSpellListViewViewModel()
    
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
        
        addSubviews(collectionView, spinner)
        addConstraints()
        
        spinner.startAnimating()
        
        viewModel.delegate = self
        viewModel.fetchSpells()
        
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


//MARK: - HPSpellListViewViewModelDelegate

extension HPSpellListView: HPSpellListViewViewModelDelegate {
    func didLoadInitialSpells() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
   
}


//MARK: - UICollectionView Extension
private extension UICollectionView {
    // Register custom cell and supplementary view identifiers.
    func registerCells() {
        // Register the custom character cell for reuse.
        register(HPCollectionViewCell.self, forCellWithReuseIdentifier: HPCollectionViewCell.identifier)
    }
}
