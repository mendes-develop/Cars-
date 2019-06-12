//
//  Car.swift
//  Carangas
//
//  Created by Alex Mendes on 5/24/19.
//  Copyright © 2019 Eric Brito. All rights reserved.
//

import Foundation

class Car: Codable {

    var _id : String?
    var brand: String = ""
    var gasType: Int = 0
    var name: String = ""
    var price: Float = 0.0
    
    var gas: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Alcohol"
        default:
            return "Gasoline"
         
        }
    }
    
}

struct Brand: Codable {
    var fipe_name : String
}
