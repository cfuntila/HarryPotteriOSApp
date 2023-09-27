//
//  HPPotion.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/26/23.
//

import Foundation

struct HPPotion: Codable {
    let id: String
    let type: String
    let attributes: HPPotionAttributes
}

struct HPPotionAttributes: Codable {
    let slug: String
    let name: String
    let effect: String?
    let side_effects: String?
    let characteristics: String?
    let time: String?
    let difficulty: String?
    let ingredients: String?
    let inventors: String?
    let manufacturers: String?
    let image: String?
    let wiki: String?
}

