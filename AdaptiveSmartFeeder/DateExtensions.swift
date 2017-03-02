//
//  DateExtensions.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 01/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import UIKit

extension Date {
    
    init(fromString string: String) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: string)
        
        self.init(timeInterval: 0, since: date!)
    }
    
}
