//
//  PetEnums.swift
//  AdaptiveSmartFeeder
//
//  Created by Vítor Chagas on 01/03/17.
//  Copyright © 2017 Adaptive Samrt Feeder. All rights reserved.
//

import Foundation

enum SizeEnum: String {
    
    case small  = "Small"
    case medium = "Medium"
    case big    = "Big"
    case giant  = "Giant"
    
    private static let values = [SizeEnum.small, SizeEnum.medium, SizeEnum.big, SizeEnum.giant]
    
    static func sizeFromIndex(_ index: Int) -> SizeEnum? {
        return index < 0 && index >= SizeEnum.values.count ? nil : SizeEnum.values[index]
    }
    
}

enum GenderEnum: String {
    
    case male   = "Male"
    case female = "Female"
}
