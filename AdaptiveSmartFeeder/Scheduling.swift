//
//  Scheduling.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 04/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

class Scheduling: NSObject {

    struct Time {
        
        var hours: Int
        var minutes: Int
        
        var description: String {
            return String.init(format: "%02d:%02d", self.hours, self.minutes)
        }
    }
    
    override var description: String {
        return "Time: \(self.time.description)\nWeight: \(self.weight)\nEnabled days: \(self.enabledDays)"
    }
    
    var time: Time
    var weight: Int
    var isActivated: Bool
    var enabledDays: [Int]
    
    init(withWeight weight: Int, hours: Int, minutes: Int, isActivated: Bool, enabledDays: [Int]?) {
        
        self.time = Time(hours: hours, minutes: minutes)
        self.weight = weight
        self.isActivated = isActivated
        self.enabledDays = enabledDays == nil ? [] : enabledDays!
        
        super.init()
        
    }
    
}
