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
    func didSelectSpell(_ spell: HPSpell)
    func didLoadMoreSpells(with paths: [IndexPath], spells: [HPSpell])
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
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    public var isLoadingMoreSpells: Bool = false
    var isPageRefreshing:Bool = false
    var page: Int = 0
    
    
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
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalSpells(url: URL) {
        guard !isLoadingMoreSpells else {
            return
        }
        isLoadingMoreSpells = true
        guard let request = HPRequest(url: url) else {
            isLoadingMoreSpells = false
            return
        }
        
        HPService.shared.execute(request, expecting: HPGetSpellsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.data
                let info = responseModel.links
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.spells.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.spells.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreSpells(
                        with: indexPathsToAdd, spells: strongSelf.spells
                    )
                    
                    strongSelf.isLoadingMoreSpells = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreSpells = false
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, shouldShowLoadMoreIndicator else {
            fatalError("Unsupported")
        }
        
        guard let footer = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HPFooterLoadingCollectionReusableView.identifier,
            for: indexPath
        ) as? HPFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100 )
    }

}

//MARK: - UICollectionViewDelegate
extension HPSpellListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected cell from collection view")
        let spell = spells[indexPath.row]
        delegate?.didSelectSpell(spell)
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

//MARK: - UIScrollViewDelegate
extension HPSpellListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreSpells,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                self?.fetchAdditionalSpells(url: url)
            }
            t.invalidate()
        }
    }
}
