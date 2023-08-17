//
//  HPCharacter.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import Foundation

struct HPCharacter: Codable {
    let id: String
    let type: String
    let attributes: HPCharacterAttributes
}

struct HPCharacterAttributes: Codable {
    let slug: String
    let name: String
    let born: String?
    let died: Bool?
    let gender: String?
    let species: String?
    let height: String?
    let weight: String?
    let hair_color: String?
    let eye_color: String?
    let skin_color: String?
    let blood_status: String?
    let marital_status: String?
    let nationality: String?
    let animagus: String?
    let boggart: String?
    let house: String?
    let patronus: String?
    
    let alias_names: [String]
    let family_members: [String]
    let jobs: [String]
    let romances: [String]
    let titles: [String]
    let wands: [String]
    let image: String?
    let wiki: String?
}
