//
//  VesselSearchResponseTests.swift
//  
//
//  Created by Mark Mroz on 2023-02-11.
//

@testable import GlobalFishWatch
import XCTest

final class EventSearchResponseTests: XCTestCase {
    func testDecoding() throws {
        let data = dataFromFixture("event_id_search")
        XCTAssertNoThrow(try JSONDecoder.globalFishWatchDecoder.decode(Event.self, from: data))
    }
}
