//
//  HPCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import UIKit

final class HPCollectionViewCellViewModel: Hashable, Equatable {
    
    //MARK: - Properties
    
    let name: String
    public let imageString: String?
    
    //MARK: - Init
    
    init(name: String, imageString: String? = "") {
        self.name = name
        self.imageString = imageString
    }
    
    //MARK: - Helpers
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageString = self.imageString, !imageString.isEmpty else {
            
            //TODO: change defaultCharactrrtImageName to just defaultImageName
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
    
    //MARK: - Hashing
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(imageString)
    }
    
    static func == (lhs: HPCollectionViewCellViewModel, rhs: HPCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
