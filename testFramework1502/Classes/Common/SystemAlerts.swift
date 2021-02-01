//
//  SystemAlerts.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 21/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest


final class SystemAlerts{
    
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    //    let errorContainer = BaseDrivePage().getApp().alerts["Error"]
    
    /// Method to accept System Alerts
    func acceptNotification(buttonName:String){
        let button = springboard.buttons[buttonName]
        let okBtn = springboard.buttons["OK"]
        let exists = NSPredicate(format:"enabled == true")
        
        let expectBtns = [
            XCTestCase().expectation(for: exists, evaluatedWith: button, handler: nil),
            XCTestCase().expectation(for: exists, evaluatedWith: okBtn, handler: nil)
        ]
        //        XCUIApplication().images[AccessibilityIdentifiers.GenericIdentifierMap.inprogressCarIndicator].verifyDisappeared(fMsg: "The In Progress indicator did not disappear")
        _ = XCTWaiter.wait(for: expectBtns, timeout: 5.0)
        //        button.exists ? button.click() : okBtn.click()
        if(button.exists) {
            button.click()
        }
        //            : XCTFail("The \"Allow\" button was not present")
        _ = expectBtns.map { $0.fulfill() }
    }
    
    ///Method to verify the Error Messages
    func verifyErrorAlert(errorMessage: String){
        //        errorContainer.staticTexts["Error"].verifyElementPresent(Msg: "The Error Title is not present")
        //        errorContainer.staticTexts[errorMessage].verifyElementPresent(Msg: "The Error message is not present")
    }
    
    
}
