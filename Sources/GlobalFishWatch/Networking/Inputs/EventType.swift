//
//  EventType.swift
//  
//
//  Created by Mark Mroz on 2023-02-02.
//

import Foundation

public enum EventType: String, Codable, Equatable {
    case encounter
    case loitering
    case gap
    case gapStart = "gap_start"
    case portVisit = "port_visit"
    case port
}
