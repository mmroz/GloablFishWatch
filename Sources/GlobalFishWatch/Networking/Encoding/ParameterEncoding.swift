//
//  ParameterEncoding.swift
//
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation

enum ParameterEncodingError: Error {
    /// An error occurred retrieving the image from the network.
    case networkError(Error)
    /// The retrieved image data could not be deserialized.
    case invalidRequestURL
}

public enum ParameterEncoding : ParameterEncoder {
    case customParameterEncoding
    case jsonEncoding(JSONParameterEncoder)
    
    // MARK: - ParameterEncoder
    
    public func encode(urlRequest: inout URLRequest, with parameters: [String: Any?]?) throws {
        guard let url = urlRequest.url else { throw ParameterEncodingError.invalidRequestURL }
        
        switch self {
        case .customParameterEncoding:
            if let parameters = parameters,
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
                urlComponents.queryItems = [URLQueryItem]()
                
                parameters.compactMapValues { $0 as? String }.forEach { (key,value) in
                    let queryItem = URLQueryItem(name: key, value: value)
                    urlComponents.queryItems?.append(queryItem)
                }
                urlRequest.url = urlComponents.url
            }
        case .jsonEncoding(let jsonEncoding):
            try? jsonEncoding.encode(urlRequest: &urlRequest, with: parameters)
        }
    }
}

