//
//  HPImageManager.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/25/23.
//

import Foundation


/// Manages images for the app
final class HPImageManager {
    static let shared = HPImageManager()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    
    /// Get image data from url
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: Callback
    public func downlaodImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        
        if let data = imageDataCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(data as Data))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let key = url.absoluteString as NSString
            let value = data as NSData
            
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
    
}
