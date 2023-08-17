//
//  HPSpell.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import Foundation

struct HPSpell: Codable {
    let id: String
    let type: String
    let attributes: HPSpellAttributes
}

struct HPSpellAttributes: Codable {
    let slug: String
    let name: String
    let incantation: String?
    let category: String?
    let effect: String?
    let light: String?
    let hand: String?
    let creator:String?
    let image: String?
    let wiki: String?
}
