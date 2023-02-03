//
//  VesselSearchResponseTests.swift
//  
//
//  Created by Mark Mroz on 2023-02-11.
//

@testable import GlobalFishWatch
import XCTest

final class VesselSearchResponseTests: XCTestCase {
    func testBasicSearchDecoding() throws {
        let data = dataFromFixture("vessel_search")
        XCTAssertNoThrow(try JSONDecoder.globalFishWatchDecoder.decode(VesselSearchResponse.self, from: data))
    }
    
    func testAdvancedSearchDecoding() throws {
        let data = dataFromFixture("vessel_advanced_search")
        XCTAssertNoThrow(try JSONDecoder.globalFishWatchDecoder.decode(VesselSearchResponse.self, from: data))
    }
    
    func testIDSearchDecoding() throws {
        let data = dataFromFixture("vessel_id_search")
        XCTAssertNoThrow(try JSONDecoder.globalFishWatchDecoder.decode(Vessel.self, from: data))
    }
}
