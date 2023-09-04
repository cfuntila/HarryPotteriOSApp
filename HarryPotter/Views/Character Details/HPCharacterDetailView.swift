//
//  HPCharacterDetailView.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import UIKit


/// View to show a character's attributes
class HPCharacterDetailView: UIView {
    
    //MARK: - Properties
    
    public var collectionView: UICollectionView?
    
    private let viewModel: HPCharacterDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    //MARK: - Init
    
    init(frame: CGRect, viewModel: HPCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .blue
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubviews(collectionView, spinner)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Helpers
    
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
        collectionView.register(HPCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: HPCharacterPhotoCollectionViewCell.identifier)
        collectionView.register(HPCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: HPCharacterInfoCollectionViewCell.identifier)
        collectionView.register(HPCharacterFamilyMemberCollectionViewCell.self, forCellWithReuseIdentifier: HPCharacterFamilyMemberCollectionViewCell.identifier)
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionTypes = viewModel.sections
        
        switch sectionTypes[sectionIndex] {
        case.photo:
            return viewModel.createPhotoSectionLayout()
        case.information:
            return viewModel.createInfoSectionLayout()
        case.familyMembers:
            return viewModel.createFamilyMembersSectionLayout()
        }
    }
    
    
}
