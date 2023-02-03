//
//  EventEncounterType.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

public enum EventEncounterType: String, Codable {
    case carrierFishing = "carrier-fishing"
    case fishingCarrier = "fishing-carrier"
    case fishingSupport = "fishing-support"
    case supportFishing = "support-fishing"
}
