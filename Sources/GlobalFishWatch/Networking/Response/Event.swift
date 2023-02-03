//
//  Event.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation
import CoreLocation

public struct Geocoodinate: Codable, Equatable {
    public let lat: Decimal
    public let lon: Decimal
    
    public var clLocationCoordinate: CLLocationCoordinate2D {
        let latDegrees = CLLocationDegrees(NSDecimalNumber(decimal: lat).doubleValue)
        let lonDegrees = CLLocationDegrees(NSDecimalNumber(decimal: lon).doubleValue)
        return CLLocationCoordinate2D(latitude: latDegrees, longitude: lonDegrees)
    }
}

public struct Region: Codable, Equatable {
    public let mpa: [Int]
    public let eez: [Int]
    public let rfmo: [Int]
}

public struct Distance: Codable, Equatable {
    public let startDistanceFromShoreKm: Decimal
    public let endDistanceFromShoreKm: Decimal
    public let startDistanceFromPortKm: Decimal
    public let endDistanceFromPortKm: Decimal
    
    enum CodingKeys: CodingKey {
        case startDistanceFromShoreKm
        case endDistanceFromShoreKm
        case startDistanceFromPortKm
        case endDistanceFromPortKm
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.startDistanceFromShoreKm = try container.decode(Decimal.self, forKey: .startDistanceFromShoreKm)
        self.endDistanceFromShoreKm = try container.decode(Decimal.self, forKey: .endDistanceFromShoreKm)
        self.startDistanceFromPortKm = try container.decode(Decimal.self, forKey: .startDistanceFromPortKm)
        self.endDistanceFromPortKm = try container.decode(Decimal.self, forKey: .endDistanceFromPortKm)
    }
}

public struct Fishing: Codable, Equatable {
    public let totalDistanceKm: Decimal
    public let averageSpeedKnots: Decimal
    public let averageDurationHours: Decimal
}

public struct EventVessel: Codable, Equatable {
    public let id: String
    public let name: String?
    public let ssvid: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case ssvid
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String?.self, forKey: .name)
        self.ssvid = try container.decode(String.self, forKey: .ssvid)
    }
}

public struct PortVisit: Codable, Equatable {
    public let visitId: String
    public let confidence: Int
    public let durationHrs: Decimal
    
    public let startAnchorage: Anchorage
    public let intermediateAnchorage: Anchorage
    public let endAnchorage: Anchorage
    
    public struct Anchorage: Codable, Equatable {
        public let id: String
        public let lat: Decimal
        public let lon: Decimal
        public let flag: String
        public let name: String
        public let atDock: Bool
        public let anchorageId: String
        public let topDestination: String
        public let distanceFromShoreKM: Int
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.lat = try container.decode(Decimal.self, forKey: .lat)
            self.lon = try container.decode(Decimal.self, forKey: .lon)
            self.flag = try container.decode(String.self, forKey: .flag)
            self.name = try container.decode(String.self, forKey: .name)
            self.atDock = try container.decode(Bool.self, forKey: .atDock)
            self.anchorageId = try container.decode(String.self, forKey: .anchorageID)
            self.topDestination = try container.decode(String.self, forKey: .topDestination)
            self.distanceFromShoreKM = try container.decode(Int.self, forKey: .distanceFromShoreKM)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(lat, forKey: .lat)
            try container.encode(lon, forKey: .lon)
            try container.encode(flag, forKey: .flag)
            try container.encode(name, forKey: .name)
            try container.encode(atDock, forKey: .atDock)
            try container.encode(anchorageId, forKey: .anchorageID)
            try container.encode(topDestination, forKey: .topDestination)
            try container.encode(distanceFromShoreKM, forKey: .distanceFromShoreKM)
        }
        
        enum CodingKeys: String, CodingKey {
            case id
            case lat
            case lon
            case flag
            case name
            case atDock = "at_dock"
            case anchorageID = "anchorage_id"
            case topDestination = "top_destination"
            case distanceFromShoreKM = "distance_from_shore_km"
        }
    }
}


public struct Event: Identifiable, Codable, Equatable {
    public let id: String
    public let type: EventResponseType
    public let start: Date
    public let end: Date
    public let position: Geocoodinate
    public let region: Region?
    public let boundingBox: [Decimal]
    public let distances: Distance
    public let vessel: EventVessel
    public let portVisit: PortVisit?
    public let fishing: Fishing?
    
    enum CodingKeys: CodingKey {
        case id
        case type
        case start
        case end
        case position
        case region
        case boundingBox
        case distances
        case vessel
        case portVisit
        case fishing
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.type = try container.decode(EventResponseType.self, forKey: .type)
        self.start = try container.decode(Date.self, forKey: .start)
        self.end = try container.decode(Date.self, forKey: .end)
        self.position = try container.decode(Geocoodinate.self, forKey: .position)
        self.region = try container.decodeIfPresent(Region.self, forKey: .region)
        self.boundingBox = try container.decode([Decimal].self, forKey: .boundingBox)
        self.distances = try container.decode(Distance.self, forKey: .distances)
        self.vessel = try container.decode(EventVessel.self, forKey: .vessel)
        self.portVisit = try container.decodeIfPresent(PortVisit.self, forKey: .portVisit)
        self.fishing = try container.decodeIfPresent(Fishing.self, forKey: .fishing)
    }
}

public struct DateRange: Codable {
    public let from: Date?
    public let to: Date?
}

public struct Geometry: Codable {
    public struct Feature: Codable {
        public let type: String
        public let geomrety: FeatureGeomrety
        
        public struct FeatureGeomrety: Codable {
            public let type: String
            public let coordinates: [[Decimal]]
        }
    }
    
    public let type: String
    public let feature: Feature
}

public struct EventListResponse: Codable {
    public struct Metadata: Codable {
        let datasets: [EventsApiDataSet]
        let dateRange: DateRange
        let encounterTypes: [EventEncounterType]
        let flags: [String]?
        let geometry: Geometry?
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.datasets = try container.decode([EventsApiDataSet].self, forKey: .datasets)
            self.dateRange = try container.decode(DateRange.self, forKey: .dateRange)
            self.encounterTypes = try container.decode([EventEncounterType].self, forKey: .encounterTypes)
            self.flags = try container.decodeIfPresent([String].self, forKey: .flags)
            self.geometry = try container.decodeIfPresent(Geometry.self, forKey: .geometry)
        }
        
        enum CodingKeys: CodingKey {
            case datasets
            case dateRange
            case encounterTypes
            case flags
            case geometry
        }
    }
    
    public let metadata: Metadata
    public let total: UInt
    public let limit: UInt?
    public let offset: UInt
    public let nextOffset: UInt64?
    public let entries: [Event]
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.metadata, forKey: .metadata)
        try container.encode(self.total, forKey: .total)
        try container.encodeIfPresent(self.limit, forKey: .limit)
        try container.encode(self.offset, forKey: .offset)
        try container.encodeIfPresent(self.nextOffset, forKey: .nextOffset)
        try container.encode(self.entries, forKey: .entries)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.metadata = try container.decode(Metadata.self, forKey: .metadata)
        self.total = try container.decode(UInt.self, forKey: .total)
        self.limit = try container.decodeIfPresent(UInt.self, forKey: .limit)
        self.offset = try container.decode(UInt.self, forKey: .offset)
        self.nextOffset = try container.decodeIfPresent(UInt64.self, forKey: .nextOffset)
        self.entries = try container.decode([Event].self, forKey: .entries)
    }
    
    enum CodingKeys: CodingKey {
        case metadata
        case total
        case limit
        case offset
        case nextOffset
        case entries
    }
}
