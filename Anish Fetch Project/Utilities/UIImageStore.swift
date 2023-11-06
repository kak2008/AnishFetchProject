//
//  UIImageStore.swift
//  Anish Fetch Project
//
//  Created by Anish Kodeboyina on 11/4/23.
//

import Foundation
import SwiftUI

protocol UIImageInterface {
    func getCachedImage(url: URL) async throws -> UIImage?
    func fetchImage(url: URL) async throws -> UIImage?
    func saveImageToCache(url: URL, response: URLResponse, data: Data)
}

class UIImageStore: UIImageInterface {
    private let urlSession: URLSession
    private let cache: URLCache
    
    init(urlSession: URLSession = .shared, cache: URLCache = .shared) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    func getCachedImage(url: URL) async throws -> UIImage? {
        let request = URLRequest(url: url)
        
        if let cachedData = cache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            return try await fetchImage(url: url)
        }
    }
    
    func fetchImage(url: URL) async throws -> UIImage? {
        let (data, response) = try await urlSession.data(from: url)
        
        guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let image = UIImage(data: data)
        saveImageToCache(url: url, response: response, data: data)
        return image
    }

    func saveImageToCache(url: URL, response: URLResponse, data: Data) {
        let request =  URLRequest(url: url)
        let cachedUrlResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedUrlResponse, for: request)
    }
}
