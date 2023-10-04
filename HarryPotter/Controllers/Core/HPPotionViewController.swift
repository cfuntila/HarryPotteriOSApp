//
//  HPPotionViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/27/23.
//

import UIKit

class HPPotionViewController: UIViewController {

    //MARK: - Views
    
    let potionsListView = HPPotionListView()
    
    //MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        title = Constants.Potion.title
        view.backgroundColor = .systemBackground
        view.addSubview(potionsListView)
        potionsListView.delegate = self
        addConstraints()
        addSearchButton()
    }
    
    private func addConstraints() {
        potionsListView.anchor(
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
        let searchVC = HPSearchViewController(config: .init(type: .potion))
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
}


//MARK: - Potion ListView Delegate

extension HPPotionViewController: HPPotionListViewDelegate {
    func didSelectPotion(_ potion: HPPotion) {
        let viewModel = HPPotionDetailViewViewModel(with: potion)
        let vc = HPPotionDetailViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
        print("push detail VC")
    }
}
