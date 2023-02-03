//
//  JSONParameterEncoder.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    private let encoder: JSONEncoder
    
    init(encoder: JSONEncoder) {
        self.encoder = encoder
    }
    
    public func encode(urlRequest: inout URLRequest, with parameters: [String: Any?]?) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters?.compactMapValues{ $0 } ?? [:])
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw GlobalFishWatchError.encodingError(error)
        }
    }
}
