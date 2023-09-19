//
//  HPSpellListViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import UIKit

//
//  HPSpellTableViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import Foundation
import UIKit

protocol HPSpellListViewViewModelDelegate: AnyObject {
    func didLoadInitialSpells()
}

final class HPSpellListViewViewModel: NSObject {
    
    public weak var delegate: HPSpellListViewViewModelDelegate?
    
    private var spells: [HPSpell] = [] {
        didSet {
            for spell in spells {
                let name = spell.attributes.name
                let imageString = spell.attributes.image
                
                let cellViewModel = HPCollectionViewCellViewModel(name: name, imageString: imageString)
                
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [HPCollectionViewCellViewModel] = []
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


//MARK: - UICollectionViewDataSource
extension HPSpellListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPCollectionViewCell.identifier, for: indexPath) as? HPCollectionViewCell else {
            fatalError("Unable to create cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }

}

//MARK: - UICollectionViewDelegate
extension HPSpellListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected cell from collection view")
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension HPSpellListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width , height: width*1.5)
    }
}
