//
//  EventEncounterType+CustomStringConvertible.swift
//  FishDemo
//
//  Created by Mark Mroz on 2023-02-01.
//

import GlobalFishWatch

extension EventEncounterType: CustomStringConvertible {
    public var description: String {
        rawValue
    }
}

extension EventEncounterType: CaseIterable {
    public static var allCases: [EventEncounterType] {
        [.carrierFishing, .fishingCarrier, .fishingSupport, .supportFishing]
    }
}
