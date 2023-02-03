//
//  VesselApiDataSet.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

public enum VesselApiDataSet {
    
    // MARK: - Private Static Properties
    
    private static let delimiter = ":"
    
    private static let fishing = "public-global-fishing-vessels"
    private static let carrier = "public-global-carrier-vessels"
    private static let support = "public-global-support-vessels"
    
    // MARK: - Public Static Properties
    
    public static let latest = "latest"
    
    case fishing(String = VesselApiDataSet.latest)
    case carrier(String = VesselApiDataSet.latest)
    case support(String = VesselApiDataSet.latest)
    
    public var qualifiedName: String {
        switch self {
        case .fishing(let version):
            return [VesselApiDataSet.fishing, version].joined(separator: VesselApiDataSet.delimiter)
        case .carrier(let version):
            return [VesselApiDataSet.carrier, version].joined(separator: VesselApiDataSet.delimiter)
        case .support(let version):
            return [VesselApiDataSet.support, version].joined(separator: VesselApiDataSet.delimiter)
        }
    }
    
    public var version: String {
        switch self {
        case .fishing(let string):
            return string
        case .carrier(let string):
            return string
        case .support(let string):
            return string
        }
    }
}

// MARK: - Codable

extension VesselApiDataSet: Codable {
    public init(from decoder: Decoder) throws {
        let decoded = try decoder.singleValueContainer()
        let decodedString = try decoded.decode(String.self)
        let components = decodedString.components(separatedBy: VesselApiDataSet.delimiter)
        guard components.count == 2,
                let dataSet = components.first,
                let version = components.last else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: String(describing: VesselApiDataSet.self)))
        }
        if dataSet == VesselApiDataSet.fishing {
            self = .fishing(version)
        } else if dataSet == VesselApiDataSet.carrier {
            self = .carrier(version)
        } else if dataSet == VesselApiDataSet.support {
            self = .support(version)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: String(describing: VesselApiDataSet.self)))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(qualifiedName)
    }
}

// MARK: - Hashable

extension VesselApiDataSet: Hashable {}
