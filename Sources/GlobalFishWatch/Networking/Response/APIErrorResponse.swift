//
//  APIErrorResponse.swift
//  
//
//  Created by Mark Mroz on 2023-01-14.
//

import Foundation

public struct APIErrorResponse: Codable, Error {
    public let error: Bool
    public let reason: String
}

public struct ResponseError: Codable, Error {
    public struct Message: Codable {
        public let title: String
        public let detail: String
    }
    
    public let statusCode: Int
    public let error: String
    public let messages: [Message]
    
    enum CodingKeys: CodingKey {
        case statusCode
        case error
        case messages
    }
}
