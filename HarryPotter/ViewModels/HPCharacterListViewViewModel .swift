//
//  HPCharacterListViewViewModel .swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import UIKit

protocol HPCharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with paths: [IndexPath], characters: [HPCharacterData])
    func didSelectCharacter(_ character: HPCharacterData)
}


final class HPCharacterListViewViewModel: NSObject {
    
    public weak var delegate: HPCharacterListViewViewModelDelegate?
    
    private var characters: [HPCharacterData] = [] {
        didSet {
            for character in characters {
                let name = character.attributes?.name ?? ""
                let imageString = character.attributes?.image
                
                let cellViewModel = HPCharacterCollectionViewCellViewModel(characterName: name, characterImageString: imageString)
                
                if !cellViewModels.contains(cellViewModel) {
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    private var apiInfo: HPLinks? = nil
    private var cellViewModels: [HPCharacterCollectionViewCellViewModel] = []
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    public var isLoadingMoreCharacters: Bool = false
    var isPageRefreshing:Bool = false
    var page: Int = 0
    
    /// Fetch first set of characters
    func fetchCharacters() {
        HPService.shared.execute(.listAllCharactersRequest, expecting: HPGetCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let results = model.data
                let info = model.links
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url: URL) {
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = HPRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        HPService.shared.execute(request, expecting: HPGetCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
                let moreResults = responseModel.data
                let info = responseModel.links
                strongSelf.apiInfo = info
                
                let originalCount = strongSelf.characters.count
                let newCount = moreResults.count
                let total = originalCount+newCount
                let startingIndex = total - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.characters.append(contentsOf: moreResults)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(
                        with: indexPathsToAdd, characters: strongSelf.characters
                    )
                    
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreCharacters = false
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension HPCharacterListViewViewModel: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HPCharacterCollectionViewCell.identifier, for: indexPath) as? HPCharacterCollectionViewCell else {
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
extension HPCharacterListViewViewModel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
        print("Selected a cell")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HPCharacterListViewViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30)/2
        return CGSize(width: width , height: width*1.5)
    }
}

//MARK: - UIScrollViewDelegate
extension HPCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString)
        else {
            return
        }

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            if(scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
