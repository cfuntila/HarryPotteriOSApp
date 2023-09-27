//
//  HPPhotoCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import UIKit

final class HPPhotoCollectionViewCellViewModel {
    private var imageString: String?
    
    init(imageString: String?) {
        self.imageString = imageString ?? ""
    }
    
    //MARK: - Helpers
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageString = self.imageString, !imageString.isEmpty else {
            let image = UIImage(named: Constants.Character.defaultImageName)!
            completion(.success(image.pngData()!))
            return
        }
        
        guard let url = URL(string: imageString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        HPImageManager.shared.downloadImage(url, completion: completion)
    }
}
