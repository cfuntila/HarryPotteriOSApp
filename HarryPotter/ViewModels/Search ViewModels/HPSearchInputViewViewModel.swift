//
//  HPSearchInputViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 10/3/23.
//

import Foundation

final class HPSearchInputViewViewModel {
    
    private let type: HPSearchViewController.Config.`Type`
    
    public enum DynamicOption: String {
        case gender = "Gender"
        case potionDifficulty = "Potion Difficulty"
        
        var choices: [String] {
            switch self {
            case .gender:
                return ["Male", "Female"]
            case .potionDifficulty:
                return ["Advanced",
                        "Advanced or Beginner",
                        "Beginner",
                        "Beginner to Moderate",
                        "Beginner to Ordinary Wizarding Level",
                        "Moderate",
                        "Moderate to Advanced",
                ]
            }
        }
    }
    
    init(type: HPSearchViewController.Config.`Type`) {
        self.type = type
    }
    
//case character // gender (Male, Female)
//case spell //
//case potion // Difficulty (Beginner, Beginner to Moderate, Moderate, Moderate/Advanced, Advanced, "Ordinary Wizarding Level", "One of a kind"
    
    //MARK: - Public
    
    public var hasDynamicOptions: Bool {
        switch type {
        case .character:
            return true
        case .spell:
            return false
        case .potion:
            return true
        }
    }
    
    public var options: [DynamicOption] {
        switch type {
        case .character:
            return [DynamicOption.gender]
        case .spell:
            return []
        case .potion:
            return [DynamicOption.potionDifficulty]
        }
    }
    
    public var searchPlaceholderText: String {
        switch type {
        case .character:
            return "Character Name"
        case .spell:
            return "Spell name or effect"
        case .potion:
            return "Potion name or effect"
        }
    }
}
