//
//  Reporting.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 17/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation
import Network

class Reporting {
    
    var testClassName: String?
    var htmlReportFolder: URL?
    let machineName = "Wynk Laptop"
    lazy var dataUtil = DataUtil()
    lazy var envProp: [String: AnyObject] = dataUtil.loadJson("environment")!
    lazy var baseTest = BaseTest()
    let userName = NSUserName()
    
    func getActiveNetwork() -> String {
        var networkType = ""
        if #available(iOS 12.0, *) {
            let nwPathMonitor = NWPathMonitor()
            nwPathMonitor.pathUpdateHandler = { path in
                
                if path.usesInterfaceType(.wifi) {
                    networkType = "WIFI"
                } else if path.usesInterfaceType(.cellular) {
                    networkType = "CELLULAR"
                } else if path.usesInterfaceType(.wiredEthernet) {
                    networkType = "WIRED_ETHERNET"
                } else if path.usesInterfaceType(.loopback) {
                    networkType = "LOOPBACK"
                } else if path.usesInterfaceType(.other) {
                    networkType = "OTHER_NETWORK"
                }
            }
        }
        
        return networkType
    }
    
    func createSummaryReport(_ testClassName: String) -> URL?{
        let executionFolder = ReportingBase.parentSuiteReportFolder?.appendingPathComponent("Execution")
        let envFolder = executionFolder?.appendingPathComponent(baseTest.getValue(dict: envProp, key: "Env"))
        let userFolder = envFolder?.appendingPathComponent(userName)
        ReportingBase.currentReportExecutionFolder = userFolder
        let testClassFolder = userFolder?.appendingPathComponent(testClassName)
        let currentTimeStamp = Date.getCurrentDate()
        TestObserver.reporter.updateValue(currentTimeStamp, forKey: "G_TimeStamp")
        TestObserver.reporter.updateValue(machineName, forKey: "G_MachineName")
        TestObserver.reporter.updateValue(userName, forKey: "G_UserName")
        let reportFolder = testClassFolder?.appendingPathComponent("HTML_REP_\(currentTimeStamp)")
        htmlReportFolder = reportFolder
        let folderExists = ((try? reportFolder?.absoluteURL.checkResourceIsReachable()) ?? false) ?? false
        do {
            if !folderExists {
                try FileManager.default.createDirectory(at: reportFolder!.absoluteURL, withIntermediateDirectories: true)
            }
            let summaryFile = reportFolder?.appendingPathComponent("Summary.html")
            let text = Data("<HTML><BODY><TABLE BORDER=0 CELLPADDING=3 CELLSPACING=1 WIDTH=100% BGCOLOR=BLACK><TR><TD WIDTH=90% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) SIZE=3><B>\(baseTest.getValue(dict: envProp, key: "orgName"))</B></FONT></TD></TR><TR><TD ALIGN=CENTER BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor"))><FONT FACE=VERDANA COLOR=WHITE SIZE=3><B>Automation Framework Reporting [\(testClassName)]</B><FONT></TD></TR></TABLE><TABLE CELLPADDING=3 WIDTH=100%><TR height=30><TD WIDTH=100% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR=//0073C5 SIZE=2><B>&nbsp; Automation Result : \(currentTimeStamp) \(machineName) by user \(userName)</B></FONT></TD></TR><TR HEIGHT=5></TR></TABLE><TABLE  CELLPADDING=3 CELLSPACING=1 WIDTH=100% style=table-layout: fixed; width: 100%><TR COLS=6 BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor"))><TD WIDTH=10%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>TC No.</B></FONT></TD><TD  WIDTH=60%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Test Name</B></FONT></TD><TD BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=15%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Status</B></FONT></TD><TD  WIDTH=15%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Test Duration</B></FONT></TD></TR>".utf8)
            try text.write(to: summaryFile!)
            return summaryFile!.absoluteURL
        }catch { print(error)
            return nil
        }
    }
    
    
    func updateThreadReportFile(_ threadCount: Int, _ testSuiteName: String, _ summaryFileUrl: URL, _ threadReportURL: URL) -> Void {
        var rowColor = "#EEEEEE"
        if threadCount % 2 == 0{
            rowColor = "#EEEEEE"
        }else{
            rowColor = "#D3D3D3"
        }
        let modelName = UIDevice.modelName
        let status = TestObserver.reporter["\(testSuiteName)_Status"] as! String
        var text = ""
        if status.uppercased() == "PASS"{
            text = "<TR COLS=3 BGCOLOR=\(rowColor)><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(threadCount)</FONT></TD><TD  WIDTH=20% STYLE=max-width:20%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(modelName)</FONT></TD><TD  WIDTH=60% STYLE=max-width:60%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(testSuiteName)</FONT></TD><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><A HREF='\(summaryFileUrl)'><FONT FACE=VERDANA SIZE=2 COLOR=GREEN><B>\(status)</B></FONT></A></TD></TR>"
        }else if status.uppercased() == "SKIP"{
            text = "<TR COLS=3 BGCOLOR=\(rowColor)><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(threadCount)</FONT></TD><TD  WIDTH=20% STYLE=max-width:20%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(modelName)</FONT></TD><TD  WIDTH=60% STYLE=max-width:60%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(testSuiteName)</FONT></TD><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><A HREF='\(summaryFileUrl)'><FONT FACE=VERDANA SIZE=2 COLOR=BLUE><B>\(status)</B></FONT></A></TD></TR>"
        }else if status.uppercased() == "FAIL"{
            text = "<TR COLS=3 BGCOLOR=\(rowColor)><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(threadCount)</FONT></TD><TD  WIDTH=20% STYLE=max-width:20%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(modelName)</FONT></TD><TD  WIDTH=60% STYLE=max-width:60%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(testSuiteName)</FONT></TD><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><A HREF='\(summaryFileUrl)'><FONT FACE=VERDANA SIZE=2 COLOR=RED><B>\(status)</B></FONT></A></TD></TR>"
        }
        
        let reportData = Data(text.utf8)
        do{
            try reportData.append(fileURL: threadReportURL)
        }catch {
            print(error)
        }
    }
    
    
    func createTestCaseHTMLReport(_ testCaseName: String, _ testClassName: String) -> URL? {
        TestObserver.reporter.updateValue(0, forKey: "\(testClassName.uppercased())_\(testCaseName.uppercased())_G_OPERATIONCOUNT")
        TestObserver.reporter.updateValue(0, forKey: "\(testClassName.uppercased())_\(testCaseName.uppercased())_G_IPASSCOUNT")
        TestObserver.reporter.updateValue(0, forKey: "\(testClassName.uppercased())_\(testCaseName.uppercased())_G_IFAILCOUNT")
        TestObserver.reporter.updateValue(0, forKey: "\(testClassName.uppercased())_\(testCaseName.uppercased())_G_SCREENSHOTCOUNT")
        let currentTimeStamp = Date.getCurrentDate()
        let htmlReportPath = htmlReportFolder
        let folderExists = ((try? htmlReportPath?.absoluteURL.checkResourceIsReachable()) ?? false) ?? false
        do {
            if !folderExists {
                try FileManager.default.createDirectory(at: htmlReportPath!.absoluteURL, withIntermediateDirectories: true)
            }
            let testReportPath = htmlReportPath?.appendingPathComponent("Report_\(testCaseName).html")
            let screenshotFolder = htmlReportFolder
            let screenshotFolderPath = screenshotFolder?.appendingPathComponent("Screenshots")
            do{
                try FileManager.default.createDirectory(at: screenshotFolderPath!, withIntermediateDirectories: false)
            }
            TestObserver.reporter.updateValue(screenshotFolderPath!, forKey: "\(testClassName.uppercased())_\(testCaseName.uppercased())_G_SCREENSHOTPATH")
            let reportData = Data("<HTML><BODY><TABLE BORDER=0 CELLPADDING=3 CELLSPACING=1 WIDTH=100% BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor"))><TR><TD WIDTH=90% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) SIZE=3><B>\(baseTest.getValue(dict: envProp, key: "orgName"))</B></FONT></TD></TR><TR><TD ALIGN=CENTER BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor"))><FONT FACE=VERDANA COLOR=WHITE SIZE=3><B>Automation Framework Reporting [\(testCaseName)]</B></FONT></TD></TR></TABLE><TABLE CELLPADDING=3 WIDTH=100%><TR height=30><TD WIDTH=100% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR=//0073C5 SIZE=2><B>&nbsp; Automation Result : \(currentTimeStamp) on Machine/Env \(machineName) by user \(userName)</B></FONT></TD></TR><TR height=30><TD WIDTH=100% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Network Mode : </B></FONT><FONT FACE=VERDANA COLOR=//0073C5 SIZE=2><B>\(getActiveNetwork())</B></FONT></TD></TR><TR HEIGHT=5></TR></TABLE><TABLE BORDER=0 BORDERCOLOR=WHITE CELLPADDING=3 CELLSPACING=1 WIDTH=100%><TR><TD BGCOLOR=BLACK WIDTH=20%><FONT FACE=VERDANA COLOR=WHITE SIZE=2><B>Test Name:</B></FONT></TD><TD COLSPAN=8 BGCOLOR=BLACK><FONT FACE=VERDANA COLOR=WHITE SIZE=2><B>\(testCaseName)</B></FONT></TD></TR></TABLE><BR/><TABLE style=table-layout: fixed; width: 100% CELLPADDING=3><TR WIDTH=100%><TH BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=5%><FONT FACE=VERDANA SIZE=2>Step No.</FONT></TH><TH BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=20%><FONT FACE=VERDANA SIZE=2>Step Description</FONT></TH><TH BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=20%><FONT FACE=VERDANA SIZE=2>Expected Value</FONT></TH><TH BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=20%><FONT FACE=VERDANA SIZE=2>Actual Value</FONT></TH><TH BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=6%><FONT FACE=VERDANA SIZE=2>Result</FONT></TH><TH BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) WIDTH=7%><FONT FACE=VERDANA SIZE=2>Time Taken</FONT></TH></TR>".utf8)
            try reportData.write(to: testReportPath!)
            
            return testReportPath!.absoluteURL
        }catch {
            print(error)
            return nil
        }
        
    }
    
    func log(_ strDescription: String, _ strExpectedValue: String, _ strObtainedValue: String, _ strResult: String) -> Void {
        let currentTestCase = TestObserver.reporter["CurrentTestCase"] as! String
        let testClassName = TestObserver.reporter["\(currentTestCase)_Suite"] as! String
        var opCount = TestObserver.reporter["\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_OPERATIONCOUNT"] as! NSInteger
        var passCount = TestObserver.reporter["\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_IPASSCOUNT"] as! NSInteger
        var failCount = TestObserver.reporter["\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_IFAILCOUNT"] as! NSInteger
        var screenshotCount = TestObserver.reporter["\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_SCREENSHOTCOUNT"] as! NSInteger
        var screenshotFolderPath:URL = URL(string: FileManager.default.currentDirectoryPath)!
        
       if  (TestObserver.reporter["\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_SCREENSHOTPATH"] != nil)
       {
        screenshotFolderPath = TestObserver.reporter["\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_SCREENSHOTPATH"] as! URL
        }
        
    
        //let sStep = "\(strDescription)<ND>\(strExpectedValue)<ND>\(strObtainedValue)<ND>\(strResult)";
        
        opCount += 1
        var sRowColor = "#EEEEEE"
        if opCount % 2 == 0{
            sRowColor = "#EEEEEE"
        }else{
            sRowColor = "#D3D3D3"
        }
        
        var reportString = "<TR WIDTH=100%><TD BGCOLOR=\(sRowColor) WIDTH=5% ALIGN=CENTER><FONT FACE=VERDANA SIZE=2 ><B>\(opCount)</B></FONT></TD><TD BGCOLOR=\(sRowColor) WIDTH=6% ALIGN=CENTER><FONT FACE=VERDANA SIZE=2 >\(strDescription)</FONT></TD><TD BGCOLOR=\(sRowColor) WIDTH=16% ALIGN=CENTER><FONT FACE=VERDANA SIZE=2 >\(strExpectedValue)</FONT></TD><TD BGCOLOR=\(sRowColor) WIDTH=20% STYLE=\"max-width:20%; word-wrap: break-word\"><FONT FACE=VERDANA SIZE=2>\(strObtainedValue)</FONT></TD>"
        
        if strResult == "PASS"{
            passCount += 1
            let screenshotsAllowed = dataUtil.getValue(dict: envProp, key: "PassStepScreenshots") as NSString
            let isScreenshotAllowed = screenshotsAllowed.boolValue
            if isScreenshotAllowed{
                ScreenshotUtil.saveScreenshot(screenShotName: "Screenshot_\(screenshotCount)", screenshotPath: screenshotFolderPath)
                let screenshotFilePath = screenshotFolderPath.appendingPathComponent("Screenshot_\(screenshotCount).png")
                screenshotCount += 1
                TestObserver.reporter.updateValue(screenshotCount, forKey: "\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_SCREENSHOTCOUNT")
                reportString = "\(reportString)<TD BGCOLOR=\(sRowColor) WIDTH=6% ALIGN=CENTER><A HREF='\(screenshotFilePath)'><FONT FACE=VERDANA SIZE=2 COLOR=GREEN><B>Pass</B></FONT></A></TD><TD BGCOLOR=\(sRowColor) WIDTH=7%><FONT FACE=VERDANA SIZE=2></FONT></TD></TR>"
            }else{
                reportString = "\(reportString)<TD BGCOLOR=\(sRowColor) WIDTH=6% ALIGN=CENTER><FONT FACE=VERDANA SIZE=2 COLOR=GREEN><B>Pass</B></FONT></TD><TD BGCOLOR=\(sRowColor) WIDTH=7%><FONT FACE=VERDANA SIZE=2></FONT></TD></TR>"
            }
        }else if strResult == "FAIL"{
            failCount += 1
            
            let screenshotsAllowed = dataUtil.getValue(dict: envProp, key: "FailStepScreenshots") as NSString
            let isScreenshotAllowed = screenshotsAllowed.boolValue
            if isScreenshotAllowed{
                ScreenshotUtil.saveScreenshot(screenShotName: "Screenshot_\(screenshotCount)", screenshotPath: screenshotFolderPath)
                let screenshotFilePath = screenshotFolderPath.appendingPathComponent("Screenshot_\(screenshotCount).png")
                screenshotCount += 1
                TestObserver.reporter.updateValue(screenshotCount, forKey: "\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_SCREENSHOTCOUNT")
                reportString = "\(reportString)<TD BGCOLOR=\(sRowColor) WIDTH=6% ALIGN=CENTER><A HREF='\(screenshotFilePath)'><FONT FACE=VERDANA SIZE=2 COLOR=RED><B>FAIL</B></FONT></A></TD><TD BGCOLOR=\(sRowColor) WIDTH=7%><FONT FACE=VERDANA SIZE=2></FONT></TD></TR>"
            }else{
                reportString = "\(reportString)<TD BGCOLOR=\(sRowColor) WIDTH=6% ALIGN=CENTER><FONT FACE=VERDANA SIZE=2 COLOR=RED><B>FAIL</B></FONT></TD><TD BGCOLOR=\(sRowColor) WIDTH=7%><FONT FACE=VERDANA SIZE=2></FONT></TD></TR>"
            }
        }
        
        TestObserver.reporter.updateValue(opCount, forKey: "\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_OPERATIONCOUNT")
        TestObserver.reporter.updateValue(passCount, forKey: "\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_IPASSCOUNT")
        TestObserver.reporter.updateValue(failCount, forKey: "\(testClassName.uppercased())_\(currentTestCase.uppercased())_G_IFAILCOUNT")
        
        var reportPath:URL = URL(string: FileManager.default.currentDirectoryPath)!
              
        if  !(TestObserver.reporter["\(currentTestCase)_ReportPath"] != nil)
        {
          reportPath = TestObserver.reporter["\(currentTestCase)_ReportPath"] as! URL
        }
       
        let reportData = Data(reportString.utf8)
        do{
            try reportData.append(fileURL: reportPath)
        }catch {
            print(error)
        }
    }
    
    func closeTestCaseHTMLReport(_ testCaseName: String, _ testClassName: String, _ testDuration: TimeInterval) -> Void {
        let passTestCasesCount = TestObserver.reporter["\(testClassName.uppercased())_\(testCaseName.uppercased())_G_IPASSCOUNT"] as! Int
        let failTestCasesCount = TestObserver.reporter["\(testClassName.uppercased())_\(testCaseName.uppercased())_G_IFAILCOUNT"] as! Int
        
        var testReportFile:URL = URL(string: FileManager.default.currentDirectoryPath)!
                     
               if  !(TestObserver.reporter["\(testCaseName)_ReportPath"] != nil)
               {
                 testReportFile = TestObserver.reporter["\(testCaseName)_ReportPath"] as! URL
               }
              
        
        
        let text = "<TR></TR><TR><TD BGCOLOR=BLACK WIDTH=5%></TD><TD BGCOLOR=BLACK WIDTH=17%></TD><TD BGCOLOR=BLACK WIDTH=35%></TD><TD BGCOLOR=BLACK WIDTH=5%></TD><TD BGCOLOR=BLACK WIDTH=10%><FONT FACE=VERDANA COLOR=WHITE SIZE=2><B>Pass Count : \(passTestCasesCount)</B></FONT></TD><TD BGCOLOR=BLACK WIDTH=15%><FONT FACE=VERDANA COLOR=WHITE SIZE=2><B>Fail Count : \(failTestCasesCount)</b></FONT></TD><TD BGCOLOR=Black WIDTH=8%></TD><TD BGCOLOR=Black WIDTH=5%></TD></TR></TABLE><TABLE WIDTH=100%><TR><TD><BR/></TD></TR><TR>"
        var testResult = ""
        if failTestCasesCount != 0{
            testResult = "Fail"
        }else{
            testResult = "Pass"
        }
        
        if failTestCasesCount == 0 && passTestCasesCount == 0{
            testResult = "Skip"
        }
        
        let reportData = Data(text.utf8)
        do{
            try reportData.append(fileURL: testReportFile)
        }catch {
            print(error)
        }
        updateTestSummaryFile(testCaseName, testClassName, testResult, testReportFile, testDuration)
    }
    
    
    func updateTestSummaryFile(_ testCaseName: String, _ testClassName: String, _ testResult: String, _ testReportFile: URL, _ testDuration: TimeInterval) -> Void {
        var strColor = "GREEN"
        let timeInString = testDuration.stringFromTimeInterval(testDuration)
        var totalPassedTestCases = TestObserver.reporter["\(testClassName)_TotalPassCount"] as! Int
        var totalFailedTestCases = TestObserver.reporter["\(testClassName)_TotalFailCount"] as! Int
        var totalSkippedTestCases = TestObserver.reporter["\(testClassName)_TotalSkipCount"] as! Int
        var totalTestCases = TestObserver.reporter["\(testClassName)_TestCaseNumber"] as! Int
        let testSummaryFile = TestObserver.reporter["\(testClassName)_SummaryFilePath"] as! URL
        totalTestCases += 1
        if testResult.uppercased() == "PASS" || testResult.uppercased() == "PASSED"{
            strColor = "GREEN"
            totalPassedTestCases += 1
        }else{
            if testResult.uppercased() == "FAIL" || testResult.uppercased() == "FAILED"{
                strColor = "RED"
                totalFailedTestCases += 1
            }else if testResult.uppercased() == "SKIP" || testResult.uppercased() == "SKIPPED"{
                strColor = "BLUE"
                totalSkippedTestCases += 1
            }else{
                strColor = baseTest.getValue(dict: envProp, key: "reportColor")
            }
        }
        var rowColor = "#EEEEEE"
        if totalTestCases % 2 == 0{
            rowColor = "#EEEEEE"
        }else{
            rowColor = "#D3D3D3"
        }
        let text = "<TR COLS=3 BGCOLOR= \(rowColor)><TD  WIDTH=10% STYLE=max-width:10%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(totalTestCases)</FONT></TD><TD  WIDTH=58% STYLE=max-width:60%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(testCaseName)</FONT></TD><TD  WIDTH=16% STYLE=max-width:15%; word-wrap: break-word><A HREF='\(testReportFile)'><FONT FACE=VERDANA SIZE=2 COLOR=\(strColor)><B>\(testResult)</B></FONT></A></TD><TD  WIDTH=16% STYLE=max-width:10%; word-wrap: break-word><FONT FACE=VERDANA SIZE=2>\(timeInString)</FONT></TD></TR>"
        let reportData = Data(text.utf8)
        do{
            try reportData.append(fileURL: testSummaryFile)
        }catch {
            print(error)
        }
        
        TestObserver.reporter.updateValue(totalPassedTestCases, forKey: "\(testClassName)_TotalPassCount")
        TestObserver.reporter.updateValue(totalFailedTestCases, forKey: "\(testClassName)_TotalFailCount")
        TestObserver.reporter.updateValue(totalSkippedTestCases, forKey: "\(testClassName)_TotalSkipCount")
        TestObserver.reporter.updateValue(totalTestCases, forKey: "\(testClassName)_TestCaseNumber")
    }
    
    func closeTestSummaryFile(_ testClassName: String, _ fileUrl: URL) -> Void {
        let totalPassedTestCases = TestObserver.reporter["\(testClassName)_TotalPassCount"] as! Int
        let totalFailedTestCases = TestObserver.reporter["\(testClassName)_TotalFailCount"] as! Int
        let totalSkippedTestCases = TestObserver.reporter["\(testClassName)_TotalSkipCount"] as! Int
        let text = "</TABLE><TABLE WIDTH=100%><TR><TD BGCOLOR=BLACK WIDTH=10%></TD><TD BGCOLOR=BLACK WIDTH=58%><FONT FACE=VERDANA SIZE=2 COLOR=WHITE><B></B></FONT></TD><TD BGCOLOR=BLACK WIDTH=16%><FONT FACE=WINGDINGS SIZE=4>2</FONT><FONT FACE=VERDANA SIZE=2 COLOR=WHITE><B>Total Passed:\(totalPassedTestCases)</B></FONT></TD></TR></TABLE><TABLE WIDTH=100%><TR><TD ALIGN=RIGHT><FONT FACE=VERDANA COLOR=\(baseTest.getValue(dict: envProp, key: "reportColor")) SIZE=1>&copy; \(baseTest.getValue(dict: envProp, key: "orgName"))</FONT></TD></TR></TABLE></BODY></HTML>"
        let reportData = Data(text.utf8)
        do{
            try reportData.append(fileURL: fileUrl)
        }catch {
            print(error)
        }
    }
    
}

