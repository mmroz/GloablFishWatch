//
//  VesselSearchResponse.swift
//  
//
//  Created by Mark Mroz on 2023-02-11.
//

import Foundation

public struct VesselSearchResponse: Codable, Equatable {
    public let metadata: VesselSearchResponse.Metadata?
    public let total: UInt
    public let limit: UInt?
    public let offset: UInt
    public let nextOffset: UInt64?
    public let entries: [Vessel]
}

extension VesselSearchResponse {
    public struct Metadata: Codable, Equatable {
        public let query: String
        public let suggestion: String?
        public let field: String?
    }
}
