//
//  VitalSignType.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class to register vital sign types that are being collected, like spo2, temperature, breath frequency, ...
class VitalSignType {
    /// vital sign name
    var name: String
    /// vital sign detailed description
    var description: String
    /// min typical measurement value
    var min: Double
    /// max typical measurement value
    var max: Double
    
    /// - parameter name: vital sign name
    /// - parameter description: vital sign detailed description
    /// - parameter min: min typical measurement value
    /// - parameter max: max typical measurement value
    init (name: String, description: String, min: Double, max: Double){
        self.name = name
        self.description = description
        self.min = min
        self.max = max
    }
}
