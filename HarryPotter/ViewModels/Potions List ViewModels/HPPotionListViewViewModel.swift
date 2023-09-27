//
//  HPPotionListViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/27/23.
//

import UIKit

protocol HPPotionListViewViewModelDelegate: AnyObject {
    func didLoadInitialPotions()
    func didLoadMorePotions(with paths: [IndexPath], potions: [HPPotion])
    func didSelectPotion(_ potion: HPPotion)
}

final class HPPotionListViewViewModel: NSObject {
    
    public weak var delegate: HPPotionListViewViewModelDelegate?
    
    private var potions: [HPPotion] = [] {
        didSet {
            for potion in potions {
                let name = potion.attributes.name
                let imageString = potion.attributes.image
                
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
    public var isLoadingMorePotions: Bool = false
    var isPageRefreshing:Bool = false
    var page: Int = 0
    
    
    func fetchPotions() {
        HPService.shared.execute(.listAllPotionsRequest, expecting: HPGetPotionsResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.data
                let info = model.links
                self?.potions = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialPotions()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalPotions(url: URL) {
        guard !isLoadingMorePotions else {
            return
        }
        isLoadingMorePotions = true
        guard let request = HPRequest(url: url) else {
            isLoadingMorePotions = false
            return
        }
        
        HPService.shared.execute(request, expecting: HPGetPotionsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.data
                let info = responseModel.links
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.potions.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.potions.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMorePotions(
                        with: indexPathsToAdd, potions: strongSelf.potions
                    )
                    
                    strongSelf.isLoadingMorePotions = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMorePotions = false
            }
        }
    }
}


//MARK: - UICollectionViewDataSource
extension HPPotionListViewViewModel: UICollectionViewDataSource {
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
extension HPPotionListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("selected cell from collection view")
        let potion = potions[indexPath.row]
        delegate?.didSelectPotion(potion)
    }
}


//MARK: - UICollectionViewDelegateFlowLayout
extension HPPotionListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width , height: width*1.5)
    }
}

//MARK: - UIScrollViewDelegate
extension HPPotionListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMorePotions,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                self?.fetchAdditionalPotions(url: url)
            }
            t.invalidate()
        }
    }
}
