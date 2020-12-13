//
//  Doctor.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class for doctors, inheriting properties from HealthCareWorker class added by two new properties for doctor's register
class Doctor : HealthCareWorker {
    
    var crm: String
    var speciality: String
    
    init (email: String, password: String, name: String, hospital: Hospital, crm: String, speciality: String) {
        self.crm = crm
        self.speciality = speciality
        
        super.init(email: email, password: password, name: name, hospital: hospital)
    }
    
}
