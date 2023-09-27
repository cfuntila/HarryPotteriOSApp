//
//  HPPotionDetailView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/27/23.
//

import UIKit

class HPPotionDetailView: UIView {
    //MARK: - Properties
    
    public var collectionView: UICollectionView?
    
    private let viewModel: HPPotionDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: HPPotionDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    private func setUpUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .blue
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }

    private func addConstraints() {
        guard let collectionView = collectionView else {
            return
        }
        spinner.center(inView: self)
        spinner.setDimensions(width: 100, height: 100)
        collectionView.anchor(
            top: topAnchor,
            bottom: bottomAnchor,
            left: leftAnchor,
            right: rightAnchor
        )
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(HPPhotoCollectionViewCell.self, forCellWithReuseIdentifier: HPPhotoCollectionViewCell.identifier)
        collectionView.register(HPInfoCollectionViewCell.self, forCellWithReuseIdentifier: HPInfoCollectionViewCell.identifier)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case.photo:
            return viewModel.createPhotoSectionLayout()
        case .info:
            return viewModel.createInfoSectionLayout()
        }
    }
    
    
}
