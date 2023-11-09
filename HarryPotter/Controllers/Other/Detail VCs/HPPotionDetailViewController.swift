//
//  HPPotionDetailViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/27/23.
//

import UIKit

class HPPotionDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: HPPotionDetailViewViewModel
    private let detailView: HPPotionDetailView
    
    //MARK: - Init
    
    init(_ viewModel: HPPotionDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = HPPotionDetailView(frame: .zero , viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: - Helpers
    
    private func setUpUI() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        title = viewModel.title
        view.addSubview(detailView)
        addConstraints()
        detailView.collectionView?.dataSource = self
        detailView.collectionView?.delegate = self
    }
    
    private func addConstraints() {
        detailView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }

}

//MARK: - CollectionView Delegate

extension HPPotionDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo, .info:
            break
        }
    }
}

//MARK: - CollectionView DataSource

extension HPPotionDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .info(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo(let viewModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPPhotoCollectionViewCell.identifier, for: indexPath) as? HPPhotoCollectionViewCell
            if let cell = cell {
                cell.configure(with: viewModel)
                cell.roundCorners()
                return cell
            } else {
                fatalError("Unsupported cell")
            }
            
        case .info(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPInfoCollectionViewCell.identifier, for: indexPath) as? HPInfoCollectionViewCell
            if let cell = cell {
                cell.configure(with: viewModels[indexPath.row])
                cell.backgroundColor = .tertiarySystemBackground
                cell.roundCorners()
                return cell
            } else {
                fatalError("Unsupported cell")
            }
        }
        
    }
}
