//
//  EventType.swift
//  
//
//  Created by Mark Mroz on 2023-01-28.
//

import Foundation

public enum EventResponseType: String, Codable, Equatable {
    case encounter
    case loitering
    case gap
    case gapStart = "gap_start"
    case portVisit = "port_visit"
    case port
    case fishing
}
