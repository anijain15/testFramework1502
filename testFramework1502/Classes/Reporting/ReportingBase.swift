//
//  ReportingBase.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 07/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation

class ReportingBase{
    
    lazy var dataUtil = DataUtil()
    lazy var envProp: [String: AnyObject] = dataUtil.loadJson("environment")!
    lazy var baseTest = BaseTest()
    
    var folderURL: URL?
    
    static var reportUrl: URL?
    static var consolidatedReportUrl: URL?
    static var parentSuiteReportFolder: URL?
    static var currentReportExecutionFolder: URL?
    let userName = NSUserName()
    
    //MARK: To create new report files
    func createNewReport() -> Void {
        let folderName = "Reports"
        let fileHeading = "Automation Test Cases Reporting"
        let reportName = "report.html"
        let consolidatedReport = "index.html"
        //let machineName = Host.current().localizedName ?? ""
        let machineName = "Wynk Laptop"
        //folderURL = createFolder(folderName: folderName)
        folderURL = getReportFolderUrl()
        let subFolder = folderURL?.appendingPathComponent("Suite_\(Date.getCurrentDate())")
        //var filePath = URL.init(fileURLWithPath: "\(folderURL)")
        print("Directory path is :")
        print(subFolder?.absoluteString)
        let folderExists = ((try? subFolder?.absoluteURL.checkResourceIsReachable()) ?? false) ?? false
        do {
            if !folderExists {
                try FileManager.default.createDirectory(at: subFolder!.absoluteURL, withIntermediateDirectories: true)
            }
            let subFolder1 = subFolder!
            ReportingBase.parentSuiteReportFolder = subFolder
            ReportingBase.reportUrl = subFolder!.appendingPathComponent(reportName)
            ReportingBase.consolidatedReportUrl = subFolder1.appendingPathComponent(consolidatedReport)
            
            let text = Data("<HTML><BODY><TABLE BORDER=0 CELLPADDING=3 CELLSPACING=1 WIDTH=100% BGCOLOR=BLACK><TR><TD WIDTH=90% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR= \(baseTest.getValue(dict: envProp, key: "reportColor")) SIZE=3><B> \(baseTest.getValue(dict: envProp, key: "orgName")) </B></FONT></TD></TR><TR><TD ALIGN=CENTER BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor"))><FONT FACE=VERDANA COLOR=WHITE SIZE=3><B>\(fileHeading)</B></FONT></TD></TR></TABLE><TABLE CELLPADDING=3 WIDTH=100%><TR height=30><TD WIDTH=100% ALIGN=CENTER BGCOLOR=WHITE><FONT FACE=VERDANA COLOR=//0073C5 SIZE=2><B>&nbsp; Automation Result : \(Date.getCurrentDate()) on Machine/Env \(machineName) by user \(userName)</B></FONT></TD></TR><TR HEIGHT=5></TR></TABLE><TABLE  CELLPADDING=3 CELLSPACING=1 WIDTH=100% style=table-layout: fixed; width: 100%><TR COLS=4 BGCOLOR=\(baseTest.getValue(dict: envProp, key: "reportColor"))><TD WIDTH=10%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Thread No.</B></FONT></TD><TD WIDTH=20%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Device/Browser Name</B></FONT></TD><TD  WIDTH=60%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Feature Name</B></FONT></TD><TD  WIDTH=10%><FONT FACE=VERDANA COLOR=BLACK SIZE=2><B>Report</B></FONT></TD></TR>".utf8)
            try text.write(to: ReportingBase.reportUrl!)
            
        } catch { print(error) }
        //        var envPath: String!
        //        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //        {
        //          app.launchEnvironment["UITEST_FILE_PATH"] = path.relativePath
        //          envPath = path.relativePath
        //          print("****************Env path \(path)******************")
        //        }
        //        var appURL = ProcessInfo.processInfo.environment["SRCROOT"]
        //        print(appURL)
    }
    
    func createFolder(folderName: String) -> URL? {
        let fileManager = FileManager.default
        // Get document directory for device, this should succeed
        if let documentDirectory = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            
            
            //        if let currentDirectory = URL(string: Bundle.main.resourcePath! + "/WynkMusicUITests.xctest/") {
            // Construct a URL with desired folder name
            let folderURL = documentDirectory.appendingPathComponent(folderName)
            // If folder URL does not exist, create it
            if !fileManager.fileExists(atPath: folderURL.path) {
                do {
                    // Attempt to create folder
                    try fileManager.createDirectory(atPath: folderURL.path,
                                                    withIntermediateDirectories: true,
                                                    attributes: nil)
                } catch {
                    // Creation failed. Print error & return nil
                    print(error.localizedDescription)
                    return nil
                }
            }
            // Folder either exists, or was created. Return URL
            return folderURL
        }
        // Will only be called if document directory not found
        return nil
        
    }
    
    func getReportFolderUrl() -> URL{
        var filePath = ""
        let fileManager = FileManager.default
        var path = Bundle.main.builtInPlugInsPath!
        path.append("/WynkMusicUITests.xctest/Info.plist")
        let dictRoot = NSDictionary(contentsOfFile: path)
        if let dict = dictRoot {
            filePath = dict["ProjectPath"] as! String
        }
        
        let reportsPath = NSURL(fileURLWithPath:filePath).appendingPathComponent("Reports")
        do {
            try fileManager.createDirectory(atPath: reportsPath!.path, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create the Reports directory \(error.debugDescription)")
        }
        return reportsPath!
    }
    
}
