//
//  HealthCareWorker.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class for healthcare worker objects, with their register information and related to their monitored patients
class HealthCareWorker {
    
    /// email to contact or to login
    var email: String
    /// password to login
    var password: String
    /// full name
    var name: String
    /// work hospital
    var hospital: Hospital
    /// patients monitored
    var patients: [Patient]
    
    /// - parameter email: email to contact or to login
    /// - parameter passwork: password to login
    /// - parameter name: full name
    /// - parameter hospital: work hospital
    init (email: String, password: String, name: String, hospital: Hospital) {
        self.email = email
        self.password = password
        self.name = name
        self.hospital = hospital
        
        self.patients = []
    }
}
