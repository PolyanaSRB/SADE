//
//  Patient.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

/// Class for patients objects, with their basic information and related to their collected vital signs
class Patient {
    /// full name
    var name: String
    /// country's document number
    var cpf: String
    /// phone number
    var phone: String
    /// date of birth
    var dateBirth: Date
    /// comorbidity
    var comorbidity: String
    /// allergy
    var allergy: String
    /// date entrance in the hospital
    var dateEntrance: Date
    /// is being monitored
    var isMonitored: Bool
    //var hospital: Hospital
    /// hospital sector that is hospitalizes
    var hospitalSector: HospitalSector?
    /// vital signs recorded
    var vitalSign: [String: [PatientVitalSign]]  //String ou VitalSignType
    /// assistant to set up HealthKit access
    var HKsetup: HealthKitSetupAssistant?
    
    /// - parameter name: full name
    /// - parameter cpf: country's document number
    /// - parameter phone: phone number
    /// - parameter dateBirth: date of birth
    /// - parameter comorbidity: comorbidity
    /// - parameter allergy: allergy
    /// - parameter dateEntrance: date entrance in the hospital
    /// - parameter isMonitored: is being monitored
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
    
    /// Add a new vital sign to the patient
    /// - parameter type: vital sign type
    /// - parameter value: recorded vital sign value
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
    
    /// Gets patients vital sign for a vital sign type
    /// - parameter type: vital sign type
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
