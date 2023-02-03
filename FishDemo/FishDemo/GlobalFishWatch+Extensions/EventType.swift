//
//  EventType+CustomStringConvertible.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-01.
//

import GlobalFishWatch

extension EventType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension EventType: CaseIterable {
    public static var allCases: [EventType] {
        [.encounter, .loitering, .gap, .gapStart, .portVisit, .port]
    }
}
