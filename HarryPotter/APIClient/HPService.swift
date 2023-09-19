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
    
    private let cacheManager = HPAPICacheManager()
    
    enum HPServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    
    /// privatized initalizer
    private init() {}
    
    
    /// Send Harry Potter API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - expecting: Type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable>(
        _ request: HPRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ){
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
            // Decode the response
            do {
                print("using cached api response")
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            return
        }
        
        guard let urlRequest = self.get_urlRequest(from: request) else {
            completion(.failure(HPServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? HPServiceError.failedToGetData))
                return
            }
            
            // Decode the response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    //MARK: - Private
    private func get_urlRequest(from hpRequest: HPRequest) -> URLRequest? {
        guard let url = hpRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = hpRequest.httpMethod
        return request
    }
}
