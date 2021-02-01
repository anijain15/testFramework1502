//
//  DataExtension.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 18/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
