//
//  FocusTimerTests.swift
//  BLTTests
//
//  Created by LorentzenN on 11/23/19.
//  Copyright © 2019 BLT App. All rights reserved.
//

import XCTest
@testable import BLT

class FocusTimerTests: XCTestCase {

    var myFocusTimer : FocusTimer = FocusTimer(1, 1)
    
    override func setUp() {
        
    }

    override func tearDown() {
        
    }
    
    func testHoldsValues() {
        myFocusTimer = FocusTimer(5, 30)
        XCTAssert(myFocusTimer.mins == 5 && myFocusTimer.secs == 30)
        myFocusTimer = FocusTimer(45, 00)
        XCTAssert(myFocusTimer.mins == 45 && myFocusTimer.secs == 00)
    }
    
    func testDescriptions() {
        myFocusTimer = FocusTimer(5, 30)
        myFocusTimer.stringMe()
        XCTAssert(myFocusTimer.description == "5:30")
        
        myFocusTimer.mins = 0
        myFocusTimer.stringMe()
        XCTAssert(myFocusTimer.description == "30")
        
        myFocusTimer.secs = 5
        myFocusTimer.mins = 1
        myFocusTimer.stringMe()
        XCTAssert(myFocusTimer.description == "1:05")
        
        myFocusTimer.secs = 0
        myFocusTimer.mins = 0
        myFocusTimer.stringMe()
        XCTAssert(myFocusTimer.description == "Timer Ended!")
    }
    
    func testUpdateVals() {
        myFocusTimer = FocusTimer(15, 00)
        for _ in 0..<5 {
            myFocusTimer.updateVals()
        }
        XCTAssert(myFocusTimer.mins == 14 && myFocusTimer.secs == 55)
        
        myFocusTimer.mins = 0
        myFocusTimer.secs = 31
        for _ in 0..<20 {
            myFocusTimer.updateVals()
        }
        XCTAssert(myFocusTimer.mins == 0 && myFocusTimer.secs == 11)
        
        for _ in 0..<11 {
            myFocusTimer.updateVals()
        }
        XCTAssert(myFocusTimer.mins == 0 && myFocusTimer.secs == 0)
    }

}
