//
//  TimeIntervalExtension.swift
//  WynkMusicUITests
//
//  Created by B0209134 on 24/08/20.
//  Copyright © 2020 Wynk. All rights reserved.
//

import Foundation


extension TimeInterval{
    
    func stringFromTimeInterval(_ interval: TimeInterval) -> String {
        
        let time = NSInteger(interval)
        
        let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
        
    }
}
