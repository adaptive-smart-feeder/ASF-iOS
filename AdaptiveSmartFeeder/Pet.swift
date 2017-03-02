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
    
    var name: String
    var birthDate: Date
    var weight: Int
    var size: SizeEnum
    var gender: GenderEnum
    
    var age: (Int, Int) {
        
        let calendar = Calendar.current
        
        let currentYear = calendar.component(.year, from: Date())
        let currentMonth = calendar.component(.month, from: Date())
        let petYear = calendar.component(.year, from: self.birthDate)
        let petMonth = calendar.component(.month, from: self.birthDate)
        
        let years = currentYear - petYear
        let months = currentMonth - petMonth
        
        return (years, months)
    }
    
    private init() {
        self.name = "Dog Pastor"
        self.birthDate = Date(fromString: "2011-01-01")
        self.weight = 6
        self.size = .giant
        self.gender = .male
    }
    
}
