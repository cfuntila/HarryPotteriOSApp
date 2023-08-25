//
//  HPCharacterCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/21/23.
//

import Foundation
import UIKit

final class HPCharacterCollectionViewCellViewModel: Hashable, Equatable {
    let characterName: String
    private let characterImageString: String
    
    init(characterName: String, characterImageString: String) {
        self.characterName = characterName
        self.characterImageString = characterImageString
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterImageString)
    }
    
    static func == (lhs: HPCharacterCollectionViewCellViewModel, rhs: HPCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        if self.characterImageString == "hat" {
            let image = UIImage(named: "hat")!
            completion(.success(image.pngData()!))
        }
        
        guard let url = URL(string: characterImageString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
