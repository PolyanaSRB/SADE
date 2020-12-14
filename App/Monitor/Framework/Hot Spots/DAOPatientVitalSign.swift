//
//  DAOPatientVitalSign.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Protocol to provide data access to patients vital sign (ideally from database), as a DAO, an architectural design pattern
protocol DAOPatientVitalSign {
    
    static func getVitalSign(patient: Patient, option: String)
    
}
