//
//  HPCharacterListView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import UIKit

protocol HPCharacterListViewDelegate: AnyObject {
    func didSelectCharacter(_ character: HPCharacterData)
}

/// View that shows list of characters and spinner
final class HPCharacterListView: UIView {
    
    private let viewModel = HPCharacterListViewViewModel()
    
    public weak var delegate: HPCharacterListViewDelegate?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HPCharacterCollectionViewCell.self, forCellWithReuseIdentifier: HPCharacterCollectionViewCell.identifier)
        collectionView.register(HPFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HPFooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
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
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            spinner.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }

}

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
        refreshCollectionView(from: paths[0][1] + 1, to: paths[99][1] - 1)
        
    }
    
    func refreshCollectionView(from: Int, to: Int) {
           if from > to {
               print("'from' index is greater than 'to' index")
               return
           }
        collectionView.performBatchUpdates{
               if from < to {
                   var indexpathArray: [IndexPath] = []
                   for index in from...to {
                       let indexpath = IndexPath(row: index, section: 0)
                       indexpathArray.append(indexpath)
                   }
                   collectionView.insertItems(at: indexpathArray)
               } else if from == to {
                   collectionView.insertItems(at: [IndexPath(row: from, section: 0)])
               }
           }
       }
}
