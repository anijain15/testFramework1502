//
//  Date.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 13/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation

extension Date {
    
    static func getCurrentDate() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd-MM-yyyyHH.mm.ss"
        
        return dateFormatter.string(from: Date())
        
    }
}
