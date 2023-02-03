//
//  VesselApiDataSetTests.swift
//  
//
//  Created by Mark Mroz on 2023-02-11.
//

import GlobalFishWatch
import XCTest

final class VesselApiDataSetTests: XCTestCase {
    func testQualifiedName() {
        XCTAssertEqual(VesselApiDataSet.fishing("v1").qualifiedName, "public-global-fishing-vessels:v1")
        XCTAssertEqual(VesselApiDataSet.carrier("v1").qualifiedName, "public-global-carrier-vessels:v1")
        XCTAssertEqual(VesselApiDataSet.support("v1").qualifiedName, "public-global-support-vessels:v1")
    }
    
    func testVersion() {
        XCTAssertEqual(VesselApiDataSet.fishing("v1").version, "v1")
        XCTAssertEqual(VesselApiDataSet.carrier("v2").version, "v2")
        XCTAssertEqual(VesselApiDataSet.support("v3").version, "v3")
    }
    
    func testDefaultVersion() {
        XCTAssertEqual(VesselApiDataSet.fishing().version, "latest")
        XCTAssertEqual(VesselApiDataSet.carrier().version, "latest")
        XCTAssertEqual(VesselApiDataSet.support().version, "latest")
    }
    
    func testEncodesQualifiedName() throws {
        XCTAssertEqual(
            String(data: try JSONEncoder().encode(VesselApiDataSet.fishing()), encoding: .utf8),
            "\"public-global-fishing-vessels:latest\""
        )
        XCTAssertEqual(
            String(data: try JSONEncoder().encode(VesselApiDataSet.carrier()), encoding: .utf8),
            "\"public-global-carrier-vessels:latest\""
        )
        XCTAssertEqual(
            String(data: try JSONEncoder().encode(VesselApiDataSet.support()), encoding: .utf8),
            "\"public-global-support-vessels:latest\""
        )
    }
    
    func testDecodesQualifiedName() throws {
        func coding(_ raw: String) throws -> VesselApiDataSet {
            return try JSONDecoder().decode(
                VesselApiDataSet.self,
                from: try JSONEncoder().encode(raw)
            )
        }
        XCTAssertEqual(try coding("public-global-fishing-vessels:v1"), .fishing("v1"))
        XCTAssertEqual(try coding("public-global-carrier-vessels:v1"), .carrier("v1"))
        XCTAssertEqual(try coding("public-global-support-vessels:v1"), .support("v1"))
    }
}
