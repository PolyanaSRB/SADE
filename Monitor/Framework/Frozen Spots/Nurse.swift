//
//  Nurse.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class for nurses, inheriting properties from HealthCareWorker class added by two new properties for nurses' register
class Nurse : HealthCareWorker {
    var corem: String
    
    init (email: String, password: String, name: String, hospital: Hospital, corem: String) {
        self.corem = corem
        
        super.init(email: email, password: password, name: name, hospital: hospital)
    }
    
}
