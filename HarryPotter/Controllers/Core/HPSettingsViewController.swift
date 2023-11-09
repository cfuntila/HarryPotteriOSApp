//
//  HPSettingsViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/29/23.
//

import StoreKit
import SafariServices
import SwiftUI
import UIKit

class HPSettingsViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var settingsSwiftUIController: UIHostingController<HPSettingsView>?

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = Constants.Settings.title
        addChildController()
        
    }
    
    //MARK: - Helpers
    
    private func addChildController() {
        let settingsSwiftUIController =  UIHostingController(
            rootView: HPSettingsView(
                viewModel:
                    HPSettingsViewViewModel(cellViewModels: HPSettingsOption.allCases.compactMap({ option in
                        return HPSettingsCellViewModel(type: option) { [weak self] option in
                            self?.handleTap(option: option)
                        }
                    }))
            )
        )
        
        addChild(settingsSwiftUIController)
        settingsSwiftUIController.didMove(toParent: self)
        view.addSubview(settingsSwiftUIController.view)
        settingsSwiftUIController.view.translatesAutoresizingMaskIntoConstraints = false
        settingsSwiftUIController.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
        self.settingsSwiftUIController = settingsSwiftUIController
    }
    
    private func handleTap(option: HPSettingsOption) {
        guard Thread.current.isMainThread else {
            return
        }
        
        if let url = option.targetUrl {
            //open website
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        } else if option == .rateApp {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
}
