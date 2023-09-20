//
//  HPImageManager.swift
//  HarryPotter
//
//  Created by Charity Funtila on 8/25/23.
//

import UIKit

/// Manages images for the app
final class HPImageManager {
    static let shared = HPImageManager()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    
    /// Get image data from url
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: Callback
    public func downloadImage(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        // Check if the image data is already cached
        if let cachedData = imageDataCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedData as Data))
            return
        }
        
        // Create a URLRequest
        let urlRequest = URLRequest(url: url)
        
        // Perform a data task
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            // Handle any network errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Check if the received image data is a GIF
            let isGif = url.absoluteString.lowercased().hasSuffix(".gif")
            
            // Process the image data
            if let imageData = data {
                if isGif {
                    // If it's a GIF, return the data as is
                    completion(.success(imageData))
                } else if let image = UIImage(data: imageData) {
                    // If it's not a GIF, check if it's a valid image
                    if let pngData = image.pngData() {
                        // If it's PNG, return PNG data
                        self?.imageDataCache.setObject(imageData as NSData, forKey: url.absoluteString as NSString)
                        completion(.success(pngData))
                    } else if let jpgData = image.jpegData(compressionQuality: 1.0) {
                        // If it's JPG, return JPG data
                        self?.imageDataCache.setObject(imageData as NSData, forKey: url.absoluteString as NSString)
                        completion(.success(jpgData))
                    } else {
                        // Handle the case where the data is not a supported image format
                        let error = NSError(domain: "com.harrypotter.imageError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Unsupported image format"])
                        completion(.failure(error))
                    }
                } else {
                    // Handle the case where the data is neither a GIF nor a valid image
                    let error = NSError(domain: "com.harrypotter.imageError", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])
                    completion(.failure(error))
                }
            } else {
                // Handle the case where no image data was received
                let error = NSError(domain: "com.harrypotter.imageError", code: 500, userInfo: [NSLocalizedDescriptionKey: "No image data received"])
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
