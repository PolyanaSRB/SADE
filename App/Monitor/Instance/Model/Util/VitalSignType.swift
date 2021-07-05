//
//  VitalSignType.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to register vital sign types that are being collected, like spo2, temperature, breath frequency, ...
class VitalSignType {
    var name: String
    var description: String
    var min: Double
    var max: Double
    
    init (name: String, description: String, min: Double, max: Double){
        self.name = name
        self.description = description
        self.min = min
        self.max = max
    }
}
