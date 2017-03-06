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
    
    static var globalId: Int = 0 //TODO: UserDefaulst
    
    var id: Int = 0
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
        
        self.id = self.getId()
    }
    
    private func getId() -> Int {
        let id = Scheduling.globalId
        Scheduling.globalId += 1
        if(Scheduling.globalId > 1000) { Scheduling.globalId = 0 }
        return id;
    }
    
    static func getSchedulings() -> [Scheduling] {
        
        let schedulingsPlist = Plist(withName: "schedulings")!
        
        let dictArray = schedulingsPlist.toArray()!.map { $0 as! [String : Any] }
        
        return dictArray.map {
            
            let timeDict    = $0["time"] as! [String : Int]
            let weight      = $0["weight"] as! Int
            let isActivated = $0["isActivated"] as! Bool
            let enabledDays = $0["enabledDays"] as! Array<Int>
            let time = Time(hours: timeDict["hours"]!, minutes: timeDict["minutes"]!)
            
            return Scheduling(withWeight: weight, hours: time.hours, minutes: time.minutes, isActivated: isActivated, enabledDays: enabledDays)
        }
    }
    
    static func saveScheduling(_ scheduling: Scheduling) {
        
        var schedulings = Scheduling.getSchedulings()
        
        let schedulingDict: [String : Any] =
        [
            "id"   : scheduling.id,
            "time" :
            [
                "hours"   : scheduling.time.hours,
                "minutes" : scheduling.time.minutes
            ],
            "weight"      : scheduling.weight,
            "isActivated" : scheduling.isActivated,
            "enabledDays" : scheduling.enabledDays
        ]
        
        var position = -1
        
        for i in (0..<schedulings.count) {
            if(schedulings[i].id == scheduling.id) {
                position = i
                break
            }
        }
        
        var schedulingsPlist = Plist(withName: "schedulings")!
        let array = schedulingsPlist.toArray()!
        
        if(position == -1) {
            array.add(schedulingDict)
        }
        else {
            array[position] = schedulingDict
        }
        
        //TODO: Send scheduling update/add to Arduino
        schedulingsPlist.load(array)
    }
}









