//
//  HPCharacterDetailViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import UIKit


/// Controller to display the details of a character
final class HPCharacterDetailViewController: UIViewController{
    
    //MARK: - Private Properties
    
    private let viewModel: HPCharacterDetailViewViewModel
    private let detailView: HPCharacterDetailView
    
    //MARK: - Init
    
    init(_ viewModel: HPCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = HPCharacterDetailView(frame: .zero , viewModel: viewModel)
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
    
    //MARK: - Family Memeber Selection
    
    func didSelectFamilyMemberCharacter(_ character: HPCharacterData) {
        let viewModel = HPCharacterDetailViewViewModel(with: character)
        let vc = HPCharacterDetailViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showFamilyMemberCharacter(with slug: String) {
        let request = HPRequest(endpoint: .characters, pathComponents: [slug])
        HPService.shared.execute(request, expecting: HPCharacter.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model
                DispatchQueue.main.async {
                    self?.didSelectFamilyMemberCharacter(results.data)
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    private func presentFamilyMember(viewModel: HPCharacterFamilyMemberCollectionViewCellViewModel) {
        let slug = viewModel.getSlug()
        showFamilyMemberCharacter(with: slug)
    }
}

//MARK: - CollectionView Delegate

extension HPCharacterDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .photo, .information:
            break
        case .familyMembers(let viewModels):
            collectionView.deselectItem(at: indexPath, animated: true)
            presentFamilyMember(viewModel: viewModels[indexPath.row])
        }
    }
}

//MARK: - CollectionView DataSource

extension HPCharacterDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let viewModels):
            return viewModels.count
        case .familyMembers(let viewModels):
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
        case .information(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPInfoCollectionViewCell.identifier, for: indexPath) as? HPInfoCollectionViewCell
            if let cell = cell {
                cell.configure(with: viewModels[indexPath.row])
                cell.backgroundColor = .tertiarySystemBackground
                cell.roundCorners()
                return cell
            } else {
                fatalError("Unsupported cell")
            }
        case .familyMembers(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPCharacterFamilyMemberCollectionViewCell.identifier, for: indexPath) as? HPCharacterFamilyMemberCollectionViewCell
            if let cell = cell {
                cell.backgroundColor = .tertiarySystemBackground
                cell.configure(with: viewModels[indexPath.row])
                cell.roundCorners()
                return cell
            } else {
                fatalError("Unsupported cell")
            }
            
        }
        
    }
}
