//
//  BasePage.swift
//  Wynk MusicUITests
//
//  Created by B0209134 on 01/07/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import XCTest


class BasePage : BaseTest{
    
    /// Getter for the currently running application instance
    ///
    /// - Returns: the instance of currently running application
    override func getApp() -> XCUIApplication{
        return BaseTest().getApp()
    }
    
    
    /// Button
    ///
    /// - Parameter name: Button Name
    /// - Returns: XCUIElement of type button
    func button(_ name: String) -> XCUIElement{
        return getApp().buttons[name]
    }
    
    /// TextField
    ///
    /// - Parameter name: TextField Identifier
    /// - Returns: XCUIElement of type TextField
    func textField(_ name: String) -> XCUIElement{
        return getApp().textFields[name]
    }
    
    
    /// Label Text
    ///
    /// - Parameter name: Text identifier
    /// - Returns: XCUIelement of type StaticText
    func text(_ name: String) -> XCUIElement{
        return getApp().staticTexts[name]
    }
    
    func other(_ name: String) -> XCUIElement{
        return getApp().otherElements[name]
    }
    
    func alert(_ name: String) -> XCUIElement{
        return getApp().alerts[name]
    }
    
    
    func getOtherApp(bundleName: String) -> XCUIApplication{
        return XCUIApplication(bundleIdentifier: bundleName)
    }
    
    
}


