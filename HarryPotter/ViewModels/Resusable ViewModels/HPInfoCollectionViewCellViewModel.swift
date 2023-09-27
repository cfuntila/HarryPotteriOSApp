//
//  HPInfoCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import Foundation

final class HPInfoCollectionViewCellViewModel {
    public let title: String
    public let value: String
    
    init(title: String, value: String) {
        self.value = value
        self.title = title
    }
}
