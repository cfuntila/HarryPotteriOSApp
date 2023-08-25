//
//  HPTabBarController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import UIKit

// Top Controller containing tabs and their root view controllers
final class HPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    private func setUpTabs() {
        let characterVC = HPCharacterViewController()
        let spellVC = HPSpellViewController()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        spellVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: characterVC)
        let nav2 = UINavigationController(rootViewController: spellVC)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        nav1.tabBarItem = UITabBarItem(title: Constants.charactersTitle,
                                       image: UIImage(systemName: "person"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: Constants.spellsTitle,
                                       image: UIImage(systemName: "pencil.and.outline"),
                                       tag: 2)
        
        setViewControllers([nav1, nav2],
                           animated: true)
    }
}

