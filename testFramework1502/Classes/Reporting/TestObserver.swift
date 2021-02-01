//
//  TestObserver.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 07/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import XCTest

class TestObserver: NSObject, XCTestObservation{
    
    let reportBase = ReportingBase()
    static var reporter: [String: Any] = [String: Any]()
    static var testClassName: String?
    // This init is called first thing as the test bundle starts up and before any test
    // initialization happens
    override init() {
        super.init()
        // We don't need to do any real work, other than register for callbacks
        // when the test suite progresses.
        // XCTestObservation keeps a strong reference to observers
        XCTestObservationCenter.shared.addTestObserver(self)
    }
    
    
    func testBundleWillStart(_ testBundle: Bundle) {
        print("Test bundle is started")
        reportBase.createNewReport()
        TestObserver.reporter.updateValue(1, forKey: "ThreadCount")
    }
    func testSuiteWillStart(_ testSuite: XCTestSuite) {
        print("Test Suite is started")
        let reporting = Reporting()
        reporting.testClassName = testSuite.name
        let summaryFilePath = reporting.createSummaryReport(testSuite.name)
        TestObserver.reporter.updateValue(summaryFilePath?.absoluteURL, forKey: "\(testSuite.name)_SummaryFilePath")
        TestObserver.reporter.updateValue(reporting, forKey: "\(testSuite.name)_ReporterObj")
        TestObserver.reporter.updateValue("PASS", forKey: "\(testSuite.name)_Status")
        
        TestObserver.reporter.updateValue(0, forKey: "\(testSuite.name)_TotalPassCount")
        TestObserver.reporter.updateValue(0, forKey: "\(testSuite.name)_TotalFailCount")
        TestObserver.reporter.updateValue(0, forKey: "\(testSuite.name)_TotalSkipCount")
        TestObserver.reporter.updateValue(0, forKey: "\(testSuite.name)_TestCaseNumber")
        let testCases = testSuite.tests
        for test in testCases {
            let reportPath = reporting.createTestCaseHTMLReport(test.name, testSuite.name)
            TestObserver.reporter.updateValue(testSuite.name, forKey: "\(test.name)_Suite")
            TestObserver.reporter.updateValue(reporting, forKey: "\(test.name)_ReporterObj")
            TestObserver.reporter.updateValue(summaryFilePath?.absoluteURL, forKey: "\(test.name)_SummaryFilePath")
            TestObserver.reporter.updateValue(reportPath?.absoluteURL, forKey: "\(test.name)_ReportPath")
            
        }
        
    }
    
    func testCaseWillStart(_ testCase: XCTestCase) {
        print("Test case is started")
        TestObserver.reporter.updateValue(testCase.name, forKey: "CurrentTestCase")
        TestObserver.reporter.updateValue("STARTED", forKey: "\(testCase.name)_Status")
    }
    func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print(testCase.name + "is failed")
        let reporter = TestObserver.reporter["\(testCase.name)_ReporterObj"] as! Reporting
        reporter.log("Test case is FAILED", "Error Description \(description)", "In file \(filePath!) at line number : \(lineNumber)", "FAIL")
        let testSuiteName = TestObserver.reporter["\(testCase.name)_Suite"] as! String
        TestObserver.reporter.updateValue("FAIL", forKey: "\(testSuiteName)_Status")
        TestObserver.reporter.updateValue("FAIL", forKey: "\(testCase.name)_Status")
    }
    func testCaseDidFinish(_ testCase: XCTestCase) {
        print("Test case finished")
        let reporter = TestObserver.reporter["\(testCase.name)_ReporterObj"] as! Reporting
        let testSuiteName = TestObserver.reporter["\(testCase.name)_Suite"] as! String
        let testDuration = testCase.testRun!.testDuration
        reporter.closeTestCaseHTMLReport(testCase.name, testSuiteName, testDuration)
        if TestObserver.reporter["\(testCase.name)_Status"] as! String == "STARTED"{
            TestObserver.reporter.updateValue("PASS", forKey: "\(testCase.name)_Status")
        }
    }
    func testSuiteDidFinish(_ testSuite: XCTestSuite) {
        print("Test suite finished")
        let reporter = TestObserver.reporter["\(testSuite.name)_ReporterObj"] as! Reporting
        let summaryFileUrl = TestObserver.reporter["\(testSuite.name)_SummaryFilePath"] as! URL
        var threadCount = TestObserver.reporter["ThreadCount"] as! Int
        reporter.updateThreadReportFile(threadCount, testSuite.name, summaryFileUrl, ReportingBase.reportUrl!)
        threadCount += 1
        TestObserver.reporter.updateValue(threadCount, forKey: "ThreadCount")
        reporter.closeTestSummaryFile(testSuite.name, summaryFileUrl)
        print("Total test cases executed \(testSuite.testRun!.executionCount)")
        print("Total test cases failed \(testSuite.testRun!.failureCount)")
        print("Total test suite duration \(testSuite.testRun!.totalDuration)")
        
        
        let testCases = testSuite.tests
        for test in testCases {
            print("Test case name \(test.name)")
            print("Test case duration \(test.testRun!.totalDuration)")
            //print("Test case status \(TestObserver.reporter["\(test.name)_Status"] as! String)")
        }
    }
    
    func testBundleDidFinish(_ testBundle: Bundle) {
        XCTestObservationCenter.shared.removeTestObserver(self)
        print("Test bundle is finished")
    }
}
