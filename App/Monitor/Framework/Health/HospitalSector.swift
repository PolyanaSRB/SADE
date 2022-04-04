//
//  HospitalSector.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class to register hospital sectors, like UTI, CTI, newborn UTI, ...
class HospitalSector {
    
    /// hospital sector name
    var name: String!
    /// hospital sector description
    var description: String
    
    /// - parameter name: hospital sector name
    /// - parameter description: hospital sector description
    init (name: String, description: String){
        self.name = name
        self.description = description
    }
}
