//
//  HPSpellDetailViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/20/23.
//

import UIKit

final class HPSpellDetailViewViewModel {
    
    private let spell: HPSpell
    
    enum SectionType {
        case photo(viewModel: HPPhotoCollectionViewCellViewModel)
        case info(viewModels: [HPInfoCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    public var title: String {
        self.spell.attributes.name
    }
    
    private let fullLayoutSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
    )
    
    //MARK: - Init
    
    init(with spell: HPSpell) {
        self.spell = spell
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
        return HPPhotoCollectionViewCellViewModel(imageString: spell.attributes.image)
    }
    
//    private func getInfoViewModels() -> [HPSpellInfoListViewCellViewModel] {
//        var infoViewModels: [HPSpellInfoListViewCellViewModel] = []
//
//        let attributes: [String: String?] = [
//            "incantation": spell.attributes.incantation,
//            "category": spell.attributes.category,
//            "effect": spell.attributes.effect,
//            "light": spell.attributes.light,
//            "hand": spell.attributes.hand,
//            "creator": spell.attributes.creator
//        ]
//
//        for attribute in attributes {
//            if let attributeValue = attribute.value {
//                infoViewModels.append(
//                    HPSpellInfoListViewCellViewModel(title: attribute.key, value: attributeValue)
//                )
//            }
//        }
//
//        return infoViewModels
//    }
    
    private func getInfoViewModels() -> [HPInfoCollectionViewCellViewModel] {
        var infoViewModels: [HPInfoCollectionViewCellViewModel] = []
        
        let attributes: [String: String?] = [
            "Incantation": spell.attributes.incantation,
            "Category": spell.attributes.category,
            "Effect": spell.attributes.effect,
            "Light": spell.attributes.light,
            "Hand": spell.attributes.hand,
            "Creator": spell.attributes.creator
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
