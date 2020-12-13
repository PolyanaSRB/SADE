//
//  HospitalSector.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to register hospital sectors, like UTI, CTI, newborn UTI, ...
class HospitalSector {
    
    var name: String!
    var description: String
    
    init (name: String, description: String){
        self.name = name
        self.description = description
    }
}
