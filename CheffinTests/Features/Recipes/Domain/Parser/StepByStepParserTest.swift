//
//  StepByStepParserTest.swift
//  CheffinTests
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import XCTest
@testable import Cheffin

final class StepByStepParserTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseIngredients() throws {
        let i = StepByStepParserImpl()
        XCTAssertEqual(
            i.parseIngredients(
                description: "Add steak to pan rest for 1 hour and 5 minutes",
                usedIngredients: ["steak"]
            ),
            "Add [steak] to pan rest for 1 hour and 5 minutes"
        )
    }
    
    func testParseUtensils() throws {
        let i = StepByStepParserImpl()
        XCTAssertEqual(
            i.parseUtensils(
                description: "Add [steak] to pan rest for 1 hour and 5 minutes",
                usedUtensils: ["pan"]
            ),
            "Add [steak] to {pan} rest for 1 hour and 5 minutes"
        )
        
        XCTAssertEqual(
            i.parseUtensils(
                description: "Season again to liking with salt,  black pepper, 4 chicken stock cubes, and shaved nutmeg",
                usedUtensils: ["Salt", "Black pepper", "Chicken stock cubes", "Nutmeg"]
            ),
            "Season again to liking with {Salt},  {Black pepper}, 4 {Chicken stock cubes}, and shaved {Nutmeg}"
        )
    }
    
    func testParseTimer() throws {
        let i = StepByStepParserImpl()
        XCTAssertEqual(
            i.parseTimer(description: "Add [steak] to {pan} rest for 1 hour and 5 minutes"),
            "Add [steak] to {pan} rest for <1 hour> and <5 minutes>"
        )
    }

}
