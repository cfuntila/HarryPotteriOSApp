//
//  HPSpellTableViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import Foundation
import UIKit

final class HPSpellTableViewCellViewModel: Hashable, Equatable {
    
    //MARK: - Properties
    
    let spellName: String
    private let spellImageString: String?
    
    //MARK: - Init
    
    init(spellName: String, spellImageString: String? = "") {
        self.spellName = spellName
        self.spellImageString = spellImageString
    }
    
    //MARK: - Helpers
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageString = self.spellImageString, !imageString.isEmpty else {
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
        hasher.combine(spellName)
        hasher.combine(spellImageString)
    }
    
    static func == (lhs: HPSpellTableViewCellViewModel, rhs: HPSpellTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
