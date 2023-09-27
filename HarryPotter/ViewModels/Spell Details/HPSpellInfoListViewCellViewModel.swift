//
//  HPSpellInfoListViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/26/23.
//

import Foundation

final class HPSpellInfoListViewCellViewModel {
    public let title: String
    public let value: String
    
    init(title: String, value: String) {
        self.value = value
        self.title = title
    }
}
