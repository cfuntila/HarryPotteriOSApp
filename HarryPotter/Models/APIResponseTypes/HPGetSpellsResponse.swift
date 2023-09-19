//
//  HPGetSpellsResponse.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/19/23.
//

import Foundation

struct HPGetSpellsResponse: Codable {
    let data: [HPSpell]
    let meta: HPMeta
    let links: HPLinks
}
