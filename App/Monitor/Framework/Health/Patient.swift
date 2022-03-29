//
//  Patient.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class for patients objects, with their basic information and related to their collected vital signs
class Patient {
    var name: String
    var cpf: String
    var phone: String
    var dateBirth: Date
    var comorbidity: String
    var allergy: String
    var dateEntrance: Date
    var isMonitored: Bool
    //var hospital: Hospital
    var hospitalSector: HospitalSector?
    var vitalSign: [String: [PatientVitalSign]]  //String ou VitalSignType
    var HKsetup: HealthKitSetupAssistant?
    
    init(name: String, cpf: String, phone: String, dateBirth: Date, comorbidity: String, allergy: String, dateEntrance: Date, isMonitored: Bool) { //}, hospitalSector: HospitalSector?) {
        
        self.name = name
        self.cpf = cpf
        self.phone = phone
        self.dateBirth = dateBirth
        self.comorbidity = comorbidity
        self.allergy = allergy
        self.dateEntrance = dateEntrance
        self.isMonitored = isMonitored
        //self.hospital = hospital
        // // self.hospitalSector = hospitalSector  ??
        self.vitalSign = [:]
    }
    
    // function to add new vital sign
    func addVitalSign(type: VitalSignType, value: Double) {
        let patientVitalSign = PatientVitalSign.init(value: value, datetime: Date(), vitalSignType: type)
        
        if var vitalSigns = self.vitalSign[patientVitalSign.vitalSignType.name] {
            vitalSigns.append(patientVitalSign)
            self.vitalSign[patientVitalSign.vitalSignType.name] = vitalSigns
        }
        else {
            self.vitalSign[patientVitalSign.vitalSignType.name] = [patientVitalSign]
            
        }
    }
    
    // function to get objects PatientVitalSign for a VitalSignType
    func getVitalSignPatient(type: VitalSignType) -> [Double] {
        var vsTuples: [Double]
        
        vsTuples = []
        if let vitalSigns = self.vitalSign[type.name] {
            for vst in vitalSigns {
                vsTuples.append(vst.value)
            }
        }
        
        return vsTuples
     }
    
}
