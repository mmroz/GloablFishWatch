//
//  VesselSearchResponse.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

public struct Vessel: Codable, Equatable {
    public let callsign: String?
    public let firstTransmissionDate: Date
    public let flag: String?
    public let geartype: String?
    public let id: String
    public let imo: String?
    public let lastTransmissionDate: Date
    public let mmsi: String
    public let msgCount: UInt64
    public let posCount: UInt64
    public let shipname: String?
    public let source: String
    public let vesselType: String
    public let years: [Int]
    public let dataset: VesselApiDataSet?
    public let score: Decimal?
}

