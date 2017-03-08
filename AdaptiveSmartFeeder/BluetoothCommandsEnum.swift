//
//  BluetoothCommandsEnum.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 05/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import Foundation

enum BluetoothCommand {
    
//  Send immediate activation command
//    
//  * mode: 0 -> Send exactly 'quantity' grams
//          1 -> Send more 'quantity' grams
//  * quantity: number of grams to be sent
    case activate(mode: Int, quantity: Int)
    
//  Set feeder's automatic mode on/off
    case setAutomatic(automatic: Bool)
    
//  Add or update a scheduling
//
//  * id: integer that identifies schedulings
//        use to know what scheduling to be updated or if it should be added a new one
//  * hours: hours of time to activate
//  * minutes: minutes of time to activate
//  * weight: quantity of grams to be provided
//  * isActivated: tells if the scheduling is set on/off
//  * enabledDays: -1   -> to be activated only once
//                 else -> array of integers mapping sunday-saturday to 0-6
    case schedule(id: Int, hours: Int, minutes: Int, weight: Int, isActivated: Bool, enabledDays: [Int]?)
    
//  Update pet attributes to modify automatic mode params
//
//  * Age: tuple with years and months of pet
//  * Weight: int with corresponding weight of pet
//  * Size: 0 - small, 1 - medium, 2 - big, 3 - giant
    case updatePetData(age: (Int, Int), weight: Int, size: SizeEnum)
    
//  Send current date from iOS to Arduino
    case sendDate
    
    // String sent to Arduino for each command
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
        
        case .sendDate:
            
            let calendar = Calendar.current
            let date = Date()
            
            let hours = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            return "date \(hours) \(minutes)"
        }
    }
    
}
