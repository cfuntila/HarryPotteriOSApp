//
//  HPCharacterCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import Foundation
import UIKit

final class HPCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    //MARK: - Properties
    
    let characterName: String
    private let characterImageString: String?
    
    //MARK: - Init
    
    init(characterName: String, characterImageString: String? = "") {
        self.characterName = characterName
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
    
    //MARK: - Hashing
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterImageString)
    }
    
    static func == (lhs: HPCharacterCollectionViewCellViewModel, rhs: HPCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
