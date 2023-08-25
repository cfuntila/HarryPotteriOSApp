//
//  HPEndpoint.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import Foundation


/// Represents Unique Harry Potter API Endpoints
@frozen enum HPEndpoint: String, CaseIterable, Hashable {
    case characters
    case spells
}
