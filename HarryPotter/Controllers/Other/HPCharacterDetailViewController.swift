//
//  HPCharacterDetailViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import UIKit


/// Controller to display the details of a character
final class HPCharacterDetailViewController: UIViewController {
    
    private let viewModel: HPCharacterDetailViewViewModel
    
    init(_ viewModel: HPCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        title = viewModel.title
    }
}
