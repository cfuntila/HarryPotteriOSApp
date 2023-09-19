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
    let spellsTableView = HPSpellsTableView()
    
    //MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        title = Constants.spellsTitle
        view.backgroundColor = .systemBackground
        view.addSubview(spellsTableView)
        addConstraints()
    }
    
    private func addConstraints() {
        spellsTableView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        
    }

}

