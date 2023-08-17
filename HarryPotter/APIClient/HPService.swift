//
//  HPService.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/17/23.
//

import Foundation


/// API Service Object to retrieve Harry Potter data
final class HPService {
    
    /// Shared Singleton instance
    static let shared = HPService()
    
    
    /// privatized initalizer
    private init() {}
    
    
    /// Send Harry Potter API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    public func execute(_ request: HPRequest, completion: @escaping () -> Void) {
        
    }
}
