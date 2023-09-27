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
        let potionVC = HPPotionViewController()
        
        let nav1 = createNavigationController(viewController: characterVC, navTitle: Constants.Character.title, imageSystemName: "person", tag: 1)
        let nav2 = createNavigationController(viewController: spellVC, navTitle: Constants.Spell.title, imageSystemName: "pencil.and.outline", tag: 2)
        let nav3 = createNavigationController(viewController: potionVC, navTitle: Constants.Potion.title, imageSystemName: "eyedropper", tag: 3)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
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

