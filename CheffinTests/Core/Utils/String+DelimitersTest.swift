//
//  String+DelimitersTest.swift
//  CheffinTests
//
//  Created by Jason Rich Darmawan Onggo Putra on 01/07/23.
//

import Foundation

import XCTest
@testable import Cheffin

final class StepByStepParserTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSeparateString() throws {
        let delimiters: [Character] = ["[", "]", "{", "}", "<", ">"]
        XCTAssertEqual(
            String.separateString("something something Add [steak] to {pan} for <5 minutes>", delimiters: delimiters),
            ["something something Add ", "[steak]", " to ", "{pan}", " for ", "<5 minutes>"]
        )
        
        XCTAssertEqual(
            String.separateString("Pat the [Meat] dry", delimiters: delimiters),
            ["Pat the ", "[Meat]", " dry"]
        )
    }


}
