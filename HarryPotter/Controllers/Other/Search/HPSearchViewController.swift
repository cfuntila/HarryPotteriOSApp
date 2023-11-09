//
//  HPSearchViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/27/23.
//

import UIKit

final class HPSearchViewController: UIViewController {
    
    struct Config {
        enum `Type` {
            case character // gender (Male, Female)
            case spell //
            case potion // Difficulty (Beginner, Beginner to Moderate, Moderate, Moderate/Advanced, Advanced, "Ordinary Wizarding Level", "One of a kind"
            
            
            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .spell:
                    return "Search Spells"
                case .potion:
                    return "Search Potions"
                }
            }
        }
        
        let type: `Type`
       
    }
    
    private let searchView: HPSearchView
    private let viewModel: HPSearchViewViewModel
    
    init(config: Config) {
         
        self.searchView = HPSearchView(frame: .zero, viewModel: HPSearchViewViewModel(config: config))
        self.viewModel = searchView.viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title =  viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapExecuteSearch))
        searchView.delegate = self
     }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    @objc
    private func didTapExecuteSearch() {
//        viewModel.executeSearch()
    }
    
    private func addConstraints() {
        searchView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}


extension HPSearchViewController: HPSearchViewDelegate {
    func hpSearchView(_ searchView: HPSearchView, didSelectOption option: HPSearchInputViewViewModel.DynamicOption) {
        print("option selected from vc")
        let vc = HPSearchOptionPickerViewController()
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }
}
