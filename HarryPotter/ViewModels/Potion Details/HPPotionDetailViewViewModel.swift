//
//  HPPotionDetailViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/27/23.
//

import Foundation

import UIKit

final class HPPotionDetailViewViewModel {
    
    private let potion: HPPotion
    
    enum SectionType {
        case photo(viewModel: HPPhotoCollectionViewCellViewModel)
        case info(viewModels: [HPInfoCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    public var title: String {
        self.potion.attributes.name
    }
    
    private let fullLayoutSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
    )
    
    //MARK: - Init
    
    init(with potion: HPPotion) {
        self.potion = potion
        setUpSections()
    }
    
    //MARK: - Sections
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: getPhotoViewModel()),
            .info(viewModels: getInfoViewModels())
        ]
    }
    
    private func getPhotoViewModel() -> HPPhotoCollectionViewCellViewModel {
        return HPPhotoCollectionViewCellViewModel(imageString: potion.attributes.image)
    }
    
    private func getInfoViewModels() -> [HPInfoCollectionViewCellViewModel] {
        var infoViewModels: [HPInfoCollectionViewCellViewModel] = []
        
        let attributes: [String: String?] = [
            "effect": potion.attributes.effect,
            "side_effects": potion.attributes.side_effects,
            "characteristics": potion.attributes.characteristics,
            "time": potion.attributes.time,
            "difficulty": potion.attributes.difficulty,
            "ingredients": potion.attributes.ingredients,
            "inventors": potion.attributes.inventors,
            "manufacturers": potion.attributes.manufacturers,
            "wiki": potion.attributes.wiki,
        ]
        
        for attribute in attributes {
            if let attributeValue = attribute.value {
                infoViewModels.append(
                    HPInfoCollectionViewCellViewModel(title: attribute.key, value: attributeValue)
                )
            }
        }
        
        return infoViewModels
    }
    
    //MARK: - Layouts
    
    public func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: fullLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize:
                NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(0.5)                ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection{
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2 , trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        return section
    }
}
