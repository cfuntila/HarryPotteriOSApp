//
//  HPCharacterDetailViewViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/24/23.
//

import UIKit

final class HPCharacterDetailViewViewModel {
    private let character: HPCharacterData
    
    enum SectionType {
        case photo(viewModel: HPPhotoCollectionViewCellViewModel)
        case information(viewModels: [HPInfoCollectionViewCellViewModel])
        case familyMembers(viewModels: [HPCharacterFamilyMemberCollectionViewCellViewModel])
    }
    
    public var sections: [SectionType] = []
    
    public var title: String {
        self.character.attributes?.name ?? Constants.Character.defaultName
    }
    
    private let fullLayoutSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: .fractionalHeight(1.0)
    )
    
    //MARK: - Init
    
    init(with character: HPCharacterData) {
        self.character = character
        setUpSections()
    }
    
    //MARK: - Sections
    
    private func setUpSections() {
        sections = [
            .photo(viewModel: getPhotoViewModel()),
            .information(viewModels: getInfoViewModels()),
            .familyMembers(viewModels: getFamilyViewModels())
        ]
    }
    
    private func getPhotoViewModel() -> HPPhotoCollectionViewCellViewModel {
        return HPPhotoCollectionViewCellViewModel(imageString: character.attributes?.image)
    }
    
    private func getInfoViewModels() -> [HPInfoCollectionViewCellViewModel] {
        var infoViewModels: [HPInfoCollectionViewCellViewModel] = []
        
        let attributes: [String: String?] = [
            "Born": character.attributes?.born,
            "Died": character.attributes?.died,
            "Gender": character.attributes?.gender,
            "Species": character.attributes?.species,
            "Height": character.attributes?.height,
            "Weight": character.attributes?.weight,
            "Hair Color": character.attributes?.hair_color,
            "Eye Color": character.attributes?.eye_color,
            "Skin Color": character.attributes?.skin_color,
            "Blood Status": character.attributes?.blood_status,
            "Marital Status": character.attributes?.marital_status,
            "Animagus": character.attributes?.animagus,
            "Boggart": character.attributes?.boggart,
            "House": character.attributes?.house,
            "Patronus": character.attributes?.patronus
        ]
        
        for attribute in attributes {
            if let attributeValue = attribute.value {
                infoViewModels.append(
                    HPInfoCollectionViewCellViewModel(title: attributeValue, value: attribute.key)
                )
            }
        }
        
        return infoViewModels
    }
    
    private func getFamilyViewModels() -> [HPCharacterFamilyMemberCollectionViewCellViewModel] {
        var familyViewModels: [HPCharacterFamilyMemberCollectionViewCellViewModel] = []
        let familyMembers = character.attributes?.family_members
        if let familyMembers = familyMembers {
            for familyMember in familyMembers {
                let familyViewModel = HPCharacterFamilyMemberCollectionViewCellViewModel(familyMemberString: familyMember)
                familyViewModels.append(familyViewModel)
            }
        }
        return familyViewModels
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
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2 , trailing: 2)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)),
            subitems: [item, item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        
        return section
    }
    
    public func createFamilyMembersSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: fullLayoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(150)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    
    
}
