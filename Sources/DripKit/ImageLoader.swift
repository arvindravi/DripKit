//
//  File.swift
//  
//
//  Created by Arvind Ravi on 05/11/2021.
//

import Foundation
import UIKit

protocol ImageLoaderType: AnyObject {
    func fetch(_ url: URL) async throws -> UIImage
    func fetch(_ urlRequest: URLRequest) async throws -> UIImage
}

actor ImageLoader {
    
    // MARK: - Custom Types -
    
    // MARK: - Private
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Swift.Error>)
        case fetched(UIImage)
    }
    
    enum Error: Swift.Error {
        case invalidResponse
        case invalidURL
        case failedToDecodeImage
    }
    
    // MARK: - Properties -
    
    private var cache = NSCache<NSURL, UIImage>()
    private var images: [URLRequest: LoaderStatus] = [:]
    private let session: URLSession
    
    // MARK: - Initialiser -
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

// MARK: - ImageLoaderType -

extension ImageLoader: ImageLoaderType {
    func fetch(_ url: URL) async throws -> UIImage {
        let request = URLRequest(url: url)
        return try await fetch(request)
    }
    
    func fetch(_ urlRequest: URLRequest) async throws -> UIImage {
        if let status = images[urlRequest] {
            switch status {
            case .fetched(let image): return image
            case .inProgress(let task): return try await task.value
            }
        }
        
        guard let url = urlRequest.url else {
            throw Error.invalidURL
        }
        
        if let image = cache.object(forKey: url as NSURL) {
            images[urlRequest] = .fetched(image)
            return image
        }
        
        let task = Task { () throws -> UIImage in
            let (data, _) = try await session.data(for: urlRequest)
            guard let image = UIImage(data: data) else {
                throw Error.failedToDecodeImage
            }
            cache.setObject(image, forKey: url as NSURL)
            return image
        }
        
        images[urlRequest] = .inProgress(task) // NOTE: This is being added before awaiting on the task so incase fetch is called by other objects while awaiting they could reuse the task, avoiding a second fetch.
        let image = try await task.value
        images[urlRequest] = .fetched(image)
        return image
    }s
}
