//
//  HPGetPotionsResponse.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/26/23.
//

import Foundation

struct HPGetPotionsResponse: Codable {
    let data: [HPPotion]
    let meta: HPMeta
    let links: HPLinks
}
