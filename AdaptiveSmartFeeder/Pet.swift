//
//  Pet.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 01/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import Foundation

class Pet {

    public static let instance = Pet()
    
    var properties: Plist = Plist(withName: "pet")!
    
    var name: String
    var birthDate: Date
    var weight: Int
    var size: SizeEnum
    var gender: GenderEnum
    
    var age: (Int, Int) {
        
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        let currentDay = calendar.component(.day, from: Date())
        let petYear = calendar.component(.year, from: self.birthDate)
        let petMonth = calendar.component(.month, from: self.birthDate)
        let petDay = calendar.component(.day, from: self.birthDate)
        
        let years = currentYear - petYear - (petMonth > currentMonth ? 1 : 0)
        var months = currentMonth - petMonth
        if months < 0 { months += 12 }
        if petDay > currentDay { months -= 1 }
        
        return (years, months)
    }
    
    private init() {
        self.name = "Dog Pastor"
        self.birthDate = Date(fromString: "2016-12-24")
        self.weight = 4
        self.size = .small
        self.gender = .male
    }
    
}

//MARK: PlistManager

extension Pet: PlistManager {
    
    func loadData() {
        
        let size    = self.properties["size"] as! Int
        let gender  = self.properties["gender"] as! Int
        self.name   = self.properties["name"] as! String
        self.weight = self.properties["weight"] as! Int
        self.size   = SizeEnum.sizeFromIndex(size)!
        self.gender = (gender == 0 ? .male : .female)
        
        let birthDate = self.properties["birthDate"] as! [String : Int]
        let day   = birthDate["day"]
        let month = birthDate["month"]
        let year  = birthDate["year"]
        self.birthDate = Date(fromString: "\(year)-\(month)-\(day)")
    }
    
    func saveData() {
        
        self.properties["name"]   = self.name
        self.properties["weight"] = self.weight
        self.properties["size"]   = self.size.hashValue
        self.properties["gender"] = self.gender.hashValue
        
        let calendar = Calendar.current
        
        let birthDateDict =
        [
            "day"   : calendar.component(.day, from: self.birthDate),
            "month" : calendar.component(.month, from: self.birthDate),
            "year"  : calendar.component(.year, from: self.birthDate)
        ]
        
        self.properties["birthDate"] = birthDateDict
        
        //TODO: Update pet data from arduino if automatic mode is set
        self.properties.save()
    }
    
}


