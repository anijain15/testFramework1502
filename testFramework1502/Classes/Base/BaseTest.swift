//
//  BaseTest.swift
//  Wynk MusicUITests
//
//  Created by B0209134 on 01/07/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest

var app: XCUIApplication = XCUIApplication()
//let registrationPage = RegistrationPage()
//let commonUtil = CommonPage()
let util = DataUtil()
//let settingPage = SettingsPage()

class BaseTest: XCTestCase{
    
    var alertCount = 0
    var startTime:Double = 0.0
    
    lazy var dataUtil = DataUtil()
    lazy var envProps : [String : AnyObject] = dataUtil.loadJson("environment")!
    
    
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        if app.exists {
            app.terminate()
        }
        app.activate()
        startTime = CFAbsoluteTimeGetCurrent()
        if alertCount < 3 {
            addUIInterruptionMonitor(withDescription: "Notification Alert") { (alert) -> Bool in
                alert.buttons["Allow"].tap()
                return true
            }
            
            alertCount = alertCount + 1
        }
        else {
            print("unable to find any alert on visible screen..")
        }
//        if registrationPage.verifySkipButtonPresence(){
//            registrationPage.clickOnSkipButton()
//        }
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func printPageSource(){
        print(app.debugDescription)
    }
    
    func getApp() -> XCUIApplication{
        return app
    }
    
    func getValue(dict: [String: AnyObject], key: String) -> String{
        return dataUtil.getValue(dict: dict, key: key)
    }
    
    func getValueAt(dict: [String: AnyObject], key: String, index: Int) -> String {
        return DataUtil().getValue(dict: dict, key: key)
    }
    
    func getStringArr(dict: [String: AnyObject], key: String) -> [String]{
        return DataUtil().getStringArr(dict:dict, key:key)
    }
    
    func getTestRunStatus() -> Int{
        return Int(self.testRun!.failureCount)
    }
    
    /// Wait class which can used by other condition based waits through predicates
    ///
    /// - Parameters:
    ///   - element: XCUIElement on which wait logic is applied
    ///   - predicate: The Condition we are waiting for
    ///   - timeout: time for which we can wait for the condition to be true
    /// - Returns: boolean representation of the result of the wait
    public func waitForPredicate(element: XCUIElement, predicate: NSPredicate, timeout: TimeInterval? = nil) -> XCTWaiter.Result{
        let xctc = XCTestCase()
        let myExpectation = xctc.expectation(for: predicate, evaluatedWith: element, handler: nil)
        let result = XCTWaiter().wait(for: [myExpectation], timeout: timeout!, enforceOrder: true)
        
        return result
    }
}


