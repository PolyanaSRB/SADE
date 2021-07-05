//
//  COVID19DAOPatientVitalSign.swift
//  Monitor
//
//  Created by user174461 on 7/13/20.
//  Copyright © 2020 Andrew Costa. All rights reserved.
//

import Foundation

// DAO to access database and collect all patients' vital signs or just the last entrance
class COVID19DAOPatientVitalSign : DAOPatientVitalSign {
    
    static func getVitalSign(patient: Patient, option: String) {
        // supose we connected to database and found the Patient Vital Signs and collect it all or just the last entrance
        // now, let's create a Patient objects for each one and save them inside HCW object
        let ecg = COVID19UsefulData.shared.ecg
        let spo2 = COVID19UsefulData.shared.spo2
        let fr = COVID19UsefulData.shared.fr
        let pas = COVID19UsefulData.shared.pas
        let pad = COVID19UsefulData.shared.pad
        let temp = COVID19UsefulData.shared.temp
        
        if option == "all" {
            for _ in 0...10 {
                patient.addVitalSign(type: ecg, value: Double(Int.random(in: 55...95)))
                patient.addVitalSign(type: spo2, value: Double(Int.random(in: 90...105)))
                patient.addVitalSign(type: fr, value: Double(Int.random(in: 10...22)))
                patient.addVitalSign(type: pas, value: Double(Int.random(in: 100...140)))
                patient.addVitalSign(type: pad, value: Double(Int.random(in: 60...95)))
                patient.addVitalSign(type: temp, value: Double(Float.random(in: 34...40)))
                
            }
        }
        else {
            patient.addVitalSign(type: ecg, value: Double(Int.random(in: 55...95)))
            patient.addVitalSign(type: spo2, value: Double(Int.random(in: 90...105)))
            patient.addVitalSign(type: fr, value: Double(Int.random(in: 10...22)))
            patient.addVitalSign(type: pas, value: Double(Int.random(in: 100...140)))
            patient.addVitalSign(type: pad, value: Double(Int.random(in: 60...95)))
            patient.addVitalSign(type: temp, value: Double(Float.random(in: 34...40)))
        }
        
    }
    
}
