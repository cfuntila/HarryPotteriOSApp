//
//  HPCharacterPhotoCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import UIKit

final class HPCharacterPhotoCollectionViewCellViewModel {
    private var characterImageString: String?
    
    init(characterImageString: String? = "") {
        self.characterImageString = characterImageString
    }
    
    //MARK: - Helpers
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageString = self.characterImageString, !imageString.isEmpty else {
            let image = UIImage(named: Constants.defaultCharacterImageName)!
            completion(.success(image.pngData()!))
            return
        }
        
        guard let url = URL(string: imageString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        HPImageManager.shared.downlaodImage(url, completion: completion)
    }
}
