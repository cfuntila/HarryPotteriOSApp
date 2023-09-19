//
//  HPSpellTableViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import Foundation
import UIKit

protocol HPSpellTableViewViewModelDelegate: AnyObject {
    func didLoadInitialSpells()
}

final class HPSpellTableViewViewModel: NSObject {
    
    public weak var delegate: HPSpellTableViewViewModelDelegate?
    
    private var spells: [HPSpell] = [] {
        didSet {
            for spell in spells {
                let name = spell.attributes.name
                let imageString = spell.attributes.image
                
                let cellViewModel = HPSpellTableViewCellViewModel(spellName: name, spellImageString: imageString)
                
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [HPSpellTableViewCellViewModel] = []
    private var apiInfo: HPLinks? = nil
    
    
    func fetchSpells() {
        HPService.shared.execute(.listAllSpellsRequest, expecting: HPGetSpellsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.data
                let info = model.links
                self?.spells = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialSpells()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension HPSpellTableViewViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HPSpellTableViewCell.identifier, for: indexPath) as? HPSpellTableViewCell else {
            fatalError("Unable to create cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
}

extension HPSpellTableViewViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected a spell!")
    }
}
