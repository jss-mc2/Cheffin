//
//  SpeechRecognizerViewModelTest.swift
//  CheffinTests
//
//  Created by Jason Rich Darmawan Onggo Putra on 28/06/23.
//

import XCTest
@testable import Cheffin

final class SpeechRecognizerViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     - Parameters:
        - words: expected value
            - one hour 25 minutes 20 seconds
            - 1 hour 25 minute 20 second
     - ToDo:
        - an hour and a half
        - an hour and a quarter
        - half an hour
        - quarter an hour
     */
    func testTranscribeTime() throws {
        let i = StepByStepPageView([])
        
        XCTAssertEqual(i.transcribeTime(["one", "hour", "25", "minutes", "20", "seconds"]), 5120)
        XCTAssertEqual(i.transcribeTime(["1", "hour", "25", "minute", "20", "second"]), 5120)
    }

}
