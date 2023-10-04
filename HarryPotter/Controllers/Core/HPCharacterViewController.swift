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
    
    /// View to hold and show all the characters retrieved from API
    private let characterListView = HPCharacterListView()

    //MARK: - Lifecyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    /// Setup UI for controller when view loads
    private func configureUI() {
        title = Constants.Character.title
        view.backgroundColor = .systemBackground
        view.addSubview(characterListView)
        characterListView.delegate = self
        addConstraints()
        addSearchButton()
    }
    
    /// Set constraints for views in controller
    func addConstraints() {
        characterListView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let searchVC = HPSearchViewController(config: .init(type: .character))
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

//MARK: - Character ListView Delegate

extension HPCharacterViewController: HPCharacterListViewDelegate {
    
    /// Show Character Details in a new controller when character is selected
    /// - Parameter character: Character user selected
    func didSelectCharacter(_ character: HPCharacterData) {
        let viewModel = HPCharacterDetailViewViewModel(with: character)
        let vc = HPCharacterDetailViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
