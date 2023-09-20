//
//  HPSpellViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import UIKit


/// Controller to show and search for Spells
final class HPSpellViewController: UIViewController {
    
    //MARK: - Views
    let spellsListView = HPSpellListView()
    
    //MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        title = Constants.spellsTitle
        view.backgroundColor = .systemBackground
        view.addSubview(spellsListView)
        spellsListView.delegate = self
        addConstraints()
    }
    
    private func addConstraints() {
        spellsListView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
    }

}

//MARK: - Character ListView Delegate

extension HPSpellViewController: HPSpellListViewDelegate {
    func didSelectSpell(_ spell: HPSpell) {
//        let viewModel = HPSpellDetailViewViewModel(with: spell)
//        let vc = HPSpellDetailViewController(viewModel)
//        navigationController?.pushViewController(vc, animated: true)
        print("push detail VC")
    }
}
