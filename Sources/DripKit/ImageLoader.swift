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

actor ImageLoader: ImageLoaderType {
    
    // MARK: - Custom Types -
    
    // MARK: - Private
    
    private enum LoaderStatus {
        case inProgress(Task<UIImage, Error>)
        case fetched(UIImage)
    }
    
    // MARK: - Properties -
    
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
        let (data, _) = try await session.data
    }
}
