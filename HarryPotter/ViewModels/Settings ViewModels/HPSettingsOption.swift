//
//  HPSettingsOption.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/29/23.
//

import UIKit

enum HPSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case iconAttribution
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https:// www.google.com")
        case .terms:
            return URL(string: "https://www.google.com")
        case .privacy:
            return URL(string: "https://www.google.com")
        case .apiReference:
            return URL(string: "https://docs.potterdb.com/")
        case .iconAttribution:
            return URL(string: "https://www.flaticon.com/free-icons/harry-potter")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms"
        case .privacy:
            return "Privacy"
        case .apiReference:
            return "API Reference"
        case .iconAttribution:
            return "Icon Attribution"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemRed
        case .terms:
            return .systemGreen
        case .privacy:
            return .systemGray
        case .apiReference:
            return .slytherinGreen
        case .iconAttribution:
            return .ravenclawBlue
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc.text")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .iconAttribution:
            return UIImage(systemName: "c.circle")
        }
    }
    
}
