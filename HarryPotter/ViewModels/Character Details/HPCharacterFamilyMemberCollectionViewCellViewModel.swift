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
    
    func extractNameAndRelationship(from input: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: "^(.*?)\\s*\\((.*?)\\)\\s*†?$")
            if let match = regex.firstMatch(in: input, range: NSRange(input.startIndex..., in: input)) {
                let nameRange = Range(match.range(at: 1), in: input)!
                let relationshipRange = Range(match.range(at: 2), in: input)!

                let name = String(input[nameRange]).trimmingCharacters(in: .whitespacesAndNewlines)
                let relationship = String(input[relationshipRange]).trimmingCharacters(in: .whitespacesAndNewlines)

                return [name, relationship]
            }
        } catch {
            print("Error: \(error)")
        }

        // If no match was found, return the original string as is
        return [input]
    }
    
    func getSlug() -> String {
        let name = extractNameAndRelationship(from: familyMemberString)[0]
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        let slug = trimmedName.replacingOccurrences(of: " ", with: "-").lowercased()
        return slug
    }
}
