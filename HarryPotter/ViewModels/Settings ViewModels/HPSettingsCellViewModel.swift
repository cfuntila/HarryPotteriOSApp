//
//  HPSettingsCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/29/23.
//

import UIKit

struct HPSettingsCellViewModel: Identifiable {
    
    let id = UUID()
    
    //MARK: - Public
    
    public var image: UIImage? {
        return type.iconImage
    }
    
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColor: UIColor {
        return type.iconContainerColor
    }
    
    //MARK: - Private
    
    public let type: HPSettingsOption
    public let onTapHandler: (HPSettingsOption) -> Void
    
    //MARK: - Init
    
    init(type: HPSettingsOption, onTapHandler: @escaping (HPSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
}
 
