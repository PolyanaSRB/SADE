//
//  PatientVitalSign.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to register new vital signs collected from database
class PatientVitalSign {
    var value: Double
    var datetime: Date
    var vitalSignType: VitalSignType
    
    init (value: Double, datetime: Date, vitalSignType: VitalSignType){
        self.value = value
        self.datetime = datetime
        self.vitalSignType = vitalSignType
    }

}
