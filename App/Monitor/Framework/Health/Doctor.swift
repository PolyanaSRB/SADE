//
//  Doctor.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class for doctors, inheriting properties from HealthCareWorker class added by two new properties for doctor's register
class Doctor : HealthCareWorker {
    /// register number in the country's medical registry
    var crm: String
    /// doctor specialty
    var speciality: String
    
    /// - parameter email: email to contact or to login
    /// - parameter passwork: password to login
    /// - parameter name: full name
    /// - parameter hospital: work hospital
    /// - parameter crm: register number in the country's medical registry
    /// - parameter speciality: doctor specialty
    init (email: String, password: String, name: String, hospital: Hospital, crm: String, speciality: String) {
        self.crm = crm
        self.speciality = speciality
        
        super.init(email: email, password: password, name: name, hospital: hospital)
    }
    
}
