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
    
    init (name: String, description: String){
        self.name = name
        self.description = description
    }
}
