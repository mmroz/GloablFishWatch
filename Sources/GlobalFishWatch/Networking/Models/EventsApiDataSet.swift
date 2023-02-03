//
//  EventsApiDataSet.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

public enum EventsApiDataSet {
    
    // MARK: - Private Static Properties
    
    private static let delimiter = ":"
    
    private static let encounters = "public-global-encounters-events"
    private static let loitering = "public-global-loitering-events-carriers"
    private static let fishing = "public-global-fishing-events"
    private static let port = "public-global-port-visits-c2-events"
    
    // MARK: - Public Static Properties
    
    public static let latest = "latest"
    
    case encounters(String = Self.latest)
    case loitering(String = Self.latest)
    case fishing(String = Self.latest)
    case port(String = Self.latest)
    
    public var qualifiedName: String {
        switch self {
        case .fishing(let version):
            return [Self.fishing, version].joined(separator: Self.delimiter)
        case .encounters(let version):
            return [Self.encounters, version].joined(separator: Self.delimiter)
        case .loitering(let version):
            return [Self.loitering, version].joined(separator: Self.delimiter)
        case .port(let version):
            return [Self.port, version].joined(separator: Self.delimiter)
        }
    }
    
    public var version: String {
        switch self {
        case .fishing(let string):
            return string
        case .encounters(let string):
            return string
        case .loitering(let string):
            return string
        case .port(let string):
            return string
        }
    }
}

// MARK: - Codable

extension EventsApiDataSet: Codable {
    public init(from decoder: Decoder) throws {
        let decoded = try decoder.singleValueContainer()
        let decodedString = try decoded.decode(String.self)
        let components = decodedString.components(separatedBy: Self.delimiter)
        guard components.count == 2,
                let dataSet = components.first,
                let version = components.last else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: String(describing: VesselApiDataSet.self)))
        }
        if dataSet == Self.fishing {
            self = .fishing(version)
        } else if dataSet == Self.encounters {
            self = .encounters(version)
        } else if dataSet == Self.port {
            self = .port(version)
        }  else if dataSet == Self.loitering {
            self = .loitering(version)
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

extension EventsApiDataSet: Hashable {}
