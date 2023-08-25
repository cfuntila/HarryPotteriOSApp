//
//  HPCharacterDetailViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import Foundation

final class HPCharacterDetailViewViewModel {
    private let character: HPCharacterData
    
    init(with character: HPCharacterData) {
        self.character = character
    }
    
    public var title: String {
        self.character.attributes?.name ?? Constants.defaultCharacterName
    }
}
