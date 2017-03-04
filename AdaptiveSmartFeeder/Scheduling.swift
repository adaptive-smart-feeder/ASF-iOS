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
            return "\(self.hours):\(self.minutes)"
        }
    }
    
    var time: Time
    var weight: Int
    var isActivated: Bool
    
    init(withWeight weight: Int, hours: Int, minutes: Int, isActivated: Bool) {
        
        self.time = Time(hours: hours, minutes: minutes)
        self.weight = weight
        self.isActivated = isActivated
    }
    
}
