//
//  HPCharacterViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import UIKit


/// Controller to show and search for Characters
final class HPCharacterViewController: UIViewController {
    
    private let characterListView = HPCharacterListView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.charactersTitle
        view.backgroundColor = .systemBackground
        view.addSubview(characterListView)
        characterListView.delegate = self
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
}

extension HPCharacterViewController: HPCharacterListViewDelegate {
    func didSelectCharacter(_ character: HPCharacterData) {
        let viewModel = HPCharacterDetailViewViewModel(with: character)
        let vc = HPCharacterDetailViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
