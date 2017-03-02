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
    
    private init() {
        self.name = "Dog Pastor"
        self.birthDate = Date(fromString: "2016-06-06")
        self.weight = 6
        self.size = .giant
        self.gender = .male
    }
    
}
