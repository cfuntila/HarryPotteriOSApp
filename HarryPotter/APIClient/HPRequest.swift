//
//  HPRequest.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import Foundation


/// Object that represents a single Harry Potter API Call
final class HPRequest {
    
    /// Request Constants
    private struct Constants {
        static let baseUrl: String = "https://api.potterdb.com/v1"
    }
    
    /// Desired Endpoint
    private let endpoint: HPEndpoint
    
    /// List of desired Path Components
    private let pathComponents: [String]
    
    /// Constructed URL String
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        for pathComponent in pathComponents {
            string += "/" + pathComponent
        }
        return string
    }
    
    //MARK: - Public
    
    /// Desired HTTP Method
    public let httpMethod = "GET"
    
    
    /// URL for API Call
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// Initialize Request
    /// - Parameters:
    ///   - endpoint: Desired Endpoint
    ///   - pathComponents: List of desired Path Components
    init(endpoint: HPEndpoint,  pathComponents: [String] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
    }
}

extension HPRequest {
    static let listAllCharactersRequest = HPRequest(endpoint: .characters)
}
