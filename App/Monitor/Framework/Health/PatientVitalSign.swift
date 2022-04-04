//
//  PatientVitalSign.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class to register new vital signs collected from database
class PatientVitalSign {
    /// recorded vital sign value
    var value: Double
    /// registration date and time
    var datetime: Date
    /// vital sign type
    var vitalSignType: VitalSignType
    
    /// - parameter value: recorded vital sign value
    /// - parameter datetime: registration date and time
    /// - parameter vitalSignType: vital sign type
    init (value: Double, datetime: Date, vitalSignType: VitalSignType){
        self.value = value
        self.datetime = datetime
        self.vitalSignType = vitalSignType
    }

}
