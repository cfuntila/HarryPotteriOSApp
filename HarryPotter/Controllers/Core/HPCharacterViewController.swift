//
//  HPCharacterViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import UIKit


/// Controller to show and search for Characters
final class HPCharacterViewController: UIViewController {
    
    //MARK: - Properties
    
    private let characterListView = HPCharacterListView()

    //MARK: - Lifecyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        title = Constants.charactersTitle
        view.backgroundColor = .systemBackground
        view.addSubview(characterListView)
        characterListView.delegate = self
        addConstraints()
    }
    
    func addConstraints() {
        characterListView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

//MARK: - Character ListView Delegate

extension HPCharacterViewController: HPCharacterListViewDelegate {
    func didSelectCharacter(_ character: HPCharacterData) {
        let viewModel = HPCharacterDetailViewViewModel(with: character)
        let vc = HPCharacterDetailViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
