//
//  Hospital.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class for hospital objects related to patients hospitalized in it and hospital sectors contained inside it
class Hospital {
    
    /// hospital name
    var name: String!
    /// hospital address
    var address: String
    //var hcws: [HealthCareWorker]
    /// patients hospitalized in the hospital
    var patients: [Patient]
    /// hospital sectors
    var sectors: [HospitalSector]
    
    /// - parameter name: hospital name
    /// - parameter address: hospital address
    init (name: String, address: String) {
        self.name = name
        self.address = address
        //self.hcws = []
        self.patients = []
        self.sectors = []
    }
    
}
