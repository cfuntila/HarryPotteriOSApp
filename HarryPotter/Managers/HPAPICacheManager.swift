//
//  HPAPICacheManager.swift
//  HarryPotter
//
//  Created by Charity Funtila on 9/18/23.
//

import Foundation

final class HPAPICacheManager {
    
    private var cacheDictionary: [HPEndpoint: NSCache<NSString, NSData>] = [:]
    
    //MARK: - Initializers
    
    init() {
        setUpCache()
    }
    
    //MARK: - Public
    
    public func cachedResponse(for endpoint: HPEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let urlString = url.absoluteString as NSString
        let targetData = targetCache.object(forKey: urlString)
        return targetData as? Data
    }
    
    public func setCache(for endpoint: HPEndpoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        
        let urlString = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: urlString)
    }
    
    //MARK: - Private
    
    private func setUpCache() {
        HPEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}
