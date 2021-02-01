//
//  XCTestExtension.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 19/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest

extension XCTest{
    
    func XCTAssertTrueWithReport(_ condition: Bool, _ failMsg: String, _ passMsg: String) -> Void {
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        if condition{
            reporting.log("Verify the assert condition", "Assertion should be verified", passMsg, "PASS")
        }else{
            reporting.log("Verify the assert condition", "Assertion should be verified", failMsg, "FAIL")
        }
        XCTAssertTrue(condition, failMsg)
    }
    
}
