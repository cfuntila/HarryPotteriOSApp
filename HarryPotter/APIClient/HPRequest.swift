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
    public var endpoint: HPEndpoint
    
    /// List of desired Path Components
    private var pathComponents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]

    
    /// Constructed URL String
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        for pathComponent in pathComponents {
            string += "/" + pathComponent
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
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
    init(endpoint: HPEndpoint,  pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }

    convenience init?(url: URL) {
        var urlString = url.absoluteString
        if !urlString.contains(Constants.baseUrl) {
            return nil
        }
        
        urlString = urlString.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if urlString.contains("/") {
            let components = urlString.components(separatedBy: "/")
            if !components.isEmpty {
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let endpoint = HPEndpoint(rawValue: components[0]) {
                    self.init(endpoint: endpoint, pathComponents: pathComponents)
                    return
                }
            }
            
        } else if urlString.contains("?") {
            let components = urlString.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let queryItemsString = components[1]
                
                let queryItems: [URLQueryItem ] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    let parts = $0.components(separatedBy: "=")
                    let name = parts[0]
                    let value = parts[1]
                    return URLQueryItem(name: name, value: value)
                })
                
                if let endpoint = HPEndpoint(rawValue: components[0]) {
                    self.init(endpoint: endpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension HPRequest {
    static let listAllCharactersRequest = HPRequest(endpoint: .characters)
    static let listAllSpellsRequest = HPRequest(endpoint: .spells)
}
