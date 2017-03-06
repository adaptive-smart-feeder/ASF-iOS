//
//  BluetoothCommandsEnum.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 05/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import Foundation

enum BluetoothCommand {
    
    // Send immediate activation command
    // Mode 0: Send exactly 'quantity' grams
    // Mode 1: Send more 'quantity' grams
    case activate(mode: Int, quantity: Int)
    
    // Set feeder's automatic mode on/off
    case setAutomatic(automatic: Bool)
    
    // Add or update a scheduling
    case schedule(id: Int, hours: Int, minutes: Int, weight: Int, isActivated: Bool, enabledDays: [Int]?)
    
    // Update pet attributes to modify automatic mode params
    case updatePetData(age: (Int, Int), weight: Int, size: SizeEnum)
    
    // String sent to Arduino
    var description: String {
        
        switch self {
            
        case let .activate(mode, quantity):
            return "ac \(mode) \(quantity)"
            
            
        case let .setAutomatic(automatic):
            return "auto \(automatic ? 1 : 0)"
            
            
        case let .schedule(id, hours, minutes, weight, isActivated, enabledDays):
            var days = ""
            if enabledDays == nil || enabledDays?.count == 0 {
                days = " -1"
            }
            else {
                enabledDays!.forEach { days += " \($0)" }
            }
            return "sch \(id) \(hours) \(minutes) \(weight) \(isActivated)\(days)"
        
        
        case let .updatePetData(age, weight, size):
            return "pet \(age.0) \(age.1) \(weight) \(size.hashValue)"
        
        }
    }
    
}
