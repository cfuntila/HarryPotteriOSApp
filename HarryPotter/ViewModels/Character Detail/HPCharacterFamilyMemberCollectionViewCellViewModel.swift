//
//  HPCharacterFamilyMemberCollectionViewCellViewModel.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/1/23.
//

import Foundation

final class HPCharacterFamilyMemberCollectionViewCellViewModel {
    public let familyMemberString: String
    private let familyMemberName: String? = ""
    private var familyMemberRelationshipType: String?
     
    init(familyMemberString: String) {
        self.familyMemberString = familyMemberString
    }
    
    public func getSlug() -> String {
        let relationshipString = familyMemberString.lowercased()
        let relationshipComponents = relationshipString.components(separatedBy: "(")
        var relationshipType = ""
        if relationshipComponents.count > 1 {
            var relationshipTypeComponents = relationshipComponents[1].components(separatedBy: ")")
            
            if let last = relationshipTypeComponents.last, last.contains("†") {
                relationshipTypeComponents.removeLast()
            }
            
            relationshipType = relationshipTypeComponents[0]
        }
        
        
        
        var slug = ""
        
        let names = relationshipComponents[0].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
        for name in names {
            slug += name
            slug += "-"
        }
        slug.removeLast()
        
        print("Slug: " + slug)
        print("relationship type: " + relationshipType)
        print()
        
        return slug
    }
}
