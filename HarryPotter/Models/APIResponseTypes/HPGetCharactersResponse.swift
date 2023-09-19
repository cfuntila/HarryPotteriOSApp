//
//  HPGetCharactersResponse.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import Foundation

struct HPGetCharactersResponse: Codable {
    let data: [HPCharacterData]
    let meta: HPMeta
    let links: HPLinks
}


