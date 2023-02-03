//
//  Fixtures+XCTest.swift
//  
//
//  Created by Mark Mroz on 2023-02-11.
//

import Foundation
@testable import GlobalFishWatch

func dataFromFixture(_ name: String) -> Data {
    let url = Bundle.module.url(forResource: name, withExtension: "json", subdirectory: "Fixtures")!
    return try! Data(contentsOf: url)
}

enum Fixture {
    static func date(year: Int, month: Int, day: Int, hour: Int, minute: Int, seconds: Int) -> Date {
        DateComponents(
            calendar: .init(identifier: .gregorian),
            timeZone: .init(identifier: "UTC"),
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: seconds
        ).date!
    }
}

extension VesselSearchResponse {
    enum TestValues {
        static var response: VesselSearchResponse = VesselSearchResponse(
            metadata: Metadata(
                query: "Xue", suggestion: nil, field: "shipname"
            ),
            total: 13,
            limit: 10,
            offset: 10,
            nextOffset: nil,
            entries: [
                Vessel.TestValues.haiXuen007,
                Vessel.TestValues.haifeng66
            ]
        )
    }
}

extension Vessel {
    enum TestValues {
        static var haiXuen007 = Vessel(
            callsign: "70067",
            firstTransmissionDate: Fixture.date(year: 2013, month: 8, day: 3, hour: 20, minute: 5, seconds: 55),
            flag: "CHN",
            geartype: "fishing",
            id: "3dda91c1f-f4f8-e71d-670e-d9d971068e55",
            imo: "0",
            lastTransmissionDate: Fixture.date(year: 2013, month: 12, day: 24, hour: 7, minute: 35, seconds: 52),
            mmsi: "412444084",
            msgCount: 17670,
            posCount: 2795,
            shipname: "HAI XUEN 007",
            source: "AIS",
            vesselType: "Fishing",
            years: [2013],
            dataset: .fishing("v20201001"),
            score: 28.237091
        )
        
        static var haifeng66 = Vessel(
            callsign: "XUEC2",
            firstTransmissionDate: Fixture.date(year: 2012, month: 3, day: 15, hour: 9, minute: 41, seconds: 52),
            flag: "KHM",
            geartype: nil,
            id: "60d65f54b-bb97-b62a-5f41-028de7c09874",
            imo: "0",
            lastTransmissionDate: Fixture.date(year: 2014, month: 12, day: 06, hour: 4, minute: 44, seconds: 59),
            mmsi: "514740000",
            msgCount: 223531,
            posCount: 2795,
            shipname: "HAIFENG66",
            source: "AIS",
            vesselType: "Carrier",
            years: [2013, 2014],
            dataset: .carrier("v20201001"),
            score: 22.900263
        )
    }
}
