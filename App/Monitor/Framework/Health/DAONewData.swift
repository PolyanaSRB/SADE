//
//  DAOPatientVitalSign.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Protocol to provide data access to patients vital sign (ideally from database), as a DAO, an architectural design pattern
protocol DAOPatientVitalSign {
    /// Gets new vital signs records for the patient
    /// - parameter patient: patient to collect new vital signs
    /// - parameter option: any required option
    static func getVitalSign(patient: Patient, option: String)
    
}
