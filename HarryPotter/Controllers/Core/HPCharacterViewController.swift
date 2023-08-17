//
//  HPCharacterViewController.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import UIKit


/// Controller to show and search for Characters
final class HPCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        
        HPService.shared.execute(.listAllCharactersRequest, expecting: HPGetCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: \(model.meta.pagination.records)")
            case .failure(let error):
                print(String(describing: error))
            }
        } 
    }
}
