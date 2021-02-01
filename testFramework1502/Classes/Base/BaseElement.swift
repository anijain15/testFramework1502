//
//  BaseElement.swift
//  Wynk MusicUITests
//
//  Created by B0209134 on 01/07/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest

var baseTest = BaseTest()
extension XCUIElement{
    
    func sendKeys(_ text: String) -> Void{
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        self.click()
        self.typeText(text)
        reporting.log("Verify user is able to enter text on element: \(self.description)", "User should be able to enter text on element: \(self.description)", "User has entered text: \(text) successfully", "PASS")
    }
    
    func clear(){
        guard let stringValue = self.value as? String else{
            return
        }
        
        if let placeholderString = self.placeholderValue, placeholderString == stringValue{
            return
        }
        
        var deleteString = String()
        for _ in stringValue{
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        
        self.typeText(deleteString)
    }
    
    
    func click() -> Bool{
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        app.images["Y"].verifyDisappeared(fMsg: "The In Progress indicator did not disappear")
        
        
        if(self.exists && self.isHittable && self.isEnabled){
            self.tap()
            reporting.log("Verify user is able to click on element: \(self.description)", "User should be able to click on element: \(self.description)", "User clicked on element: \(self.description) successfully", "PASS")
            return true
        }
            
        else if(self.exists && !(self.isHittable && self.isEnabled)){
            reporting.log("Verify user is able to click on element: \(self.description)", "User should be able to click on element: \(self.description)", "Element: \(self.description) exists in the dom but it is not visible on the screen", "FAIL")
            // XCTFail("The Element >>"+self.description+"<< exists in the dom but it is not visible on the screen")
            return false
        }
            
        else if(!self.exists){
            reporting.log("Verify user is able to click on element: \(self.description)", "User should be able to click on element: \(self.description)", "Element: \(self.description) is not present on the screen", "FAIL")
            
            verifyEnabled(fMsg: "The Element >>"+self.description+"<< is not present on the screen.")
            
            print("Please check the screenshots in this folder "+ScreenshotUtil().getScreenshotFolderPath().standardizedFileURL.absoluteString)
            
            return false
            
        }
        
        return false
    }
    
    
    func verifyElementPresence() -> Bool{
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        if self.exists{
            reporting.log("Verify presence of element: \(self.description)", "Verify element is present: \(self.description)", "Element: \(self.description) is present", "PASS")
        }else{
            reporting.log("Verify presence of element: \(self.description)", "Verify element is present: \(self.description)", "Element: \(self.description) is not present", "PASS")
        }
        return self.exists
    }
    
    /// Waits for an element to appear.
    ///
    /// - Parameter fMsg: "Message to be displayed on failure"
    func verifyPresent(fMsg: String? = "The element did not appear even after "+(BaseTest().envProps["timeout"] as! NSString).doubleValue.description+" seconds") -> Bool{
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        let elementPresence: Bool = baseTest.waitForPredicate(element: self, predicate: NSPredicate(format: "exists == true"), timeout: (BaseTest().envProps["timeout"] as!  NSString).doubleValue) == .completed
        if elementPresence{
            reporting.log("Verify presence of element: \(self.description)", "Verify element is present: \(self.description)", "Element: \(self.description) is present", "PASS")
            return true
        }else{
            reporting.log("Verify presence of element: \(self.description)", "Verify element is present: \(self.description)", "Element: \(self.description) is not present", "FAIL")
            return false
        }
        return false
       // XCTAssertTrue(elementPresence , fMsg!)
    }
    
    /// Waits for an element to disappear.
    ///
    /// - Parameter fMsg: Message to be displayed on failure
    func verifyDisappeared(fMsg: String? = "The element did not get disapper even after "+(BaseTest().envProps["timeout"] as! NSString).doubleValue.description+" seconds"){
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        let elementPresence: Bool = baseTest.waitForPredicate(element: self, predicate: NSPredicate(format: "exists == false"), timeout: (BaseTest().envProps["timeout"] as! NSString).doubleValue) == .completed
        if elementPresence{
            reporting.log("Verify disappearence of element: \(self.description)", "Verify element is disappeared: \(self.description)", "Element: \(self.description) is disappeared", "PASS")
        }else{
            reporting.log("Verify disappearence of element: \(self.description)", "Verify element is disappeared: \(self.description)", "Element: \(self.description) is not disappeared", "FAIL")
        }
        XCTAssertTrue(elementPresence, fMsg!)
    }
    
    
    /// Waits for an element to be enabled.
    ///
    /// - Parameter fMsg: Message to be displayed on failure
    func verifyEnabled(fMsg: String? = "The element is not enabled even after "+(BaseTest().envProps["timeout"] as!  NSString).doubleValue.description+" seconds"){
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        let elementEnabled: Bool = baseTest.waitForPredicate(element: self, predicate: NSPredicate(format: "enabled == true AND hittable == true"), timeout: (BaseTest().envProps["timeout"] as!  NSString).doubleValue) == .completed
        
        if elementEnabled{
            reporting.log("Verify that element: \(self.description) is enabled", "Verify element is enabled: \(self.description)", "Element: \(self.description) is enabled", "PASS")
        }else{
            reporting.log("Verify that element: \(self.description) is enabled", "Verify element is enabled: \(self.description)", "Element: \(self.description) is not enabled", "FAIL")
        }
        // XCTAssertTrue(elementEnabled,fMsg!)
    }
    
    
    /// Waits for an element to disappear.
    ///
    /// - Parameter fMsg: Message to be displayed on failure
    func verifyDisabled(fMsg: String? = "The element did not get disabled even after "+(BaseTest().envProps["timeout"] as!  NSString).doubleValue.description+" seconds"){
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        let elementDisabled: Bool = baseTest.waitForPredicate(element: self, predicate: NSPredicate(format: "exists == false"), timeout: (BaseTest().envProps["timeout"] as!  NSString).doubleValue) == .completed
        if elementDisabled{
            reporting.log("Verify that element: \(self.description) is disabled", "Verify element is disabled: \(self.description)", "Element: \(self.description) is disabled", "PASS")
        }else{
            reporting.log("Verify that element: \(self.description) is disabled", "Verify element is disabled: \(self.description)", "Element: \(self.description) is not disabled", "FAIL")
        }
        XCTAssertTrue(elementDisabled, fMsg!)
    }
    
    
    func verifyText(text: String, Msg: String)
    {
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        verifyPresent(fMsg: Msg)
        if self.label == text{
            reporting.log("Verify that text: \(text) is present", "Verify that text: \(text) is present", "Text: \(text) is matched", "PASS")
        }else{
            reporting.log("Verify that text: \(text) is present", "Verify that text: \(text) is present", "Text: \(text) is not matched", "FAIL")
        }
        XCTAssertEqual(self.label, text, "Expected: "+text+" Actual: "+self.label+" "+Msg)
    }
    
    func verifyContainsText(text: String, Msg: String){
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        verifyPresent(fMsg: Msg)
        if self.label.contains(text){
            reporting.log("Verify that text: \(text) is present", "Verify that text: \(text) is present", "Text: \(text) is matched", "PASS")
        }else{
            reporting.log("Verify that text: \(text) is present", "Verify that text: \(text) is present", "Text: \(text) is not matched", "FAIL")
        }
        XCTAssertTrue(self.label.contains(text), "Expected: "+text+" Actual: "+self.label+" "+Msg)
    }
    
    func verifyValue(value: String, fMessage: String)
    {
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        verifyPresent(fMsg: fMessage)
        if self.value as! String == value{
            reporting.log("Verify that text: \(value) is present", "Verify that text: \(value) is present", "Text: \(value) is matched", "PASS")
        }else{
            reporting.log("Verify that text: \(value) is present", "Verify that text: \(value) is present", "Text: \(value) is not matched", "FAIL")
        }
        XCTAssertEqual(self.value as! String, value, fMessage)
    }
    
    
    /// This method is used to capture the screenshot of the element
    ///
    /// - Parameter screenShotName: The name of the screenshot
    func screenShot(_ screenShotName: String){
        let fileName = ScreenshotUtil().getScreenshotFolderPath().appendingPathComponent(screenShotName+self.description+".png")
        try? self.screenshot().image.pngData()?.write(to: fileName, options: .atomic)
        
    }
    
    /**
     swipe untill element is found
     */
    func swipeUpUntillElementFind() ->Bool {
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let reporting = TestObserver.reporter["\(currentTestCase)_ReporterObj"] as! Reporting
        var flag:Bool = false
        
        
        if self.exists && self.isHittable{
            
            flag = true
            reporting.log("Verify that text: \(self.label) is present", "Verify that text: \(self.label) is present", "\(self.label)  is scrolled", "PASS")
            return flag
            
        }
        else{
            while !flag{
                app.swipeUp()
                if self.exists && self.isHittable {
                    flag = true
                    reporting.log("Verify that text: \(self.label) is present", "Verify that text: \(self.label) is present", "\(self.label)  is scrolled", "PASS")
                    return flag
                }
            }
        }
        if !flag
        {
            reporting.log("Verify that text: \(self.label) is present", "Verify that text: \(self.label) is present", "\(self.label)  is not scrolled", "FAIL")
        }
        return flag
        
    }
    
    
}

