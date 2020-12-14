//
//  HealthCareWorker.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class for healthcare worker objects, with their register information and related to their monitored patients
class HealthCareWorker {
    
    var email: String
    var password: String
    var name: String
    var hospital: Hospital
    var patients: [Patient]
    
    init (email: String, password: String, name: String, hospital: Hospital) {
        self.email = email
        self.password = password
        self.name = name
        self.hospital = hospital
        
        self.patients = []
    }
}
