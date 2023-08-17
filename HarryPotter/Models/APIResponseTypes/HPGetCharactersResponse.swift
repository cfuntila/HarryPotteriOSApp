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

//MARK: - HPMeta
struct HPMeta: Codable {
    let pagination: HPPagination
    let copyright: String
    let generated_at: String
}

struct HPPagination: Codable {
    let current: Int
    let next: Int
    let last: Int
    let records: Int
}

//MARK: - HPLinks
struct HPLinks: Codable {
    let `self`: String
    let current: String
    let next: String?
    let last: String?
}
