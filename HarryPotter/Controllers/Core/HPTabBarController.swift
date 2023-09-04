//
//  HPTabBarController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import UIKit

// Top Controller containing tabs and their root view controllers
final class HPTabBarController: UITabBarController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    //MARK: - Helpers
    
    private func setUpTabs() {
        let characterVC = HPCharacterViewController()
        let spellVC = HPSpellViewController()
        
        let nav1 = createNavigationController(viewController: characterVC, navTitle: Constants.charactersTitle, imageSystemName: "person", tag: 1)
        let nav2 = createNavigationController(viewController: spellVC, navTitle: Constants.spellsTitle, imageSystemName: "pencil.and.outline", tag: 2)
        
        setViewControllers([nav1, nav2], animated: true)
    }
    
    private func createNavigationController(viewController: UIViewController, navTitle title: String, imageSystemName: String, tag: Int) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.navigationBar.prefersLargeTitles = true
        nav.tabBarItem = UITabBarItem(title: title,
                                       image: UIImage(systemName: imageSystemName),
                                       tag: tag)
        return nav
    }
    
}

