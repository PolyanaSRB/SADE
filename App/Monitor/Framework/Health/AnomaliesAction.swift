//
//  AnomaliesAction.swift
//  Monitor
//
//  Created by user174461 on 3/12/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation

/// AnomaliesAction class extends from OneShotAction class to detect anomalies considering typical values range of each vital sign
class AnomaliesAction: OneShotAction {
    
    /// action execution result as a dictionary where the key is the patient where an anomaly was found, and the value is the message to alert about the anomaly
    var result: [(patient: Patient, message: String)] = []
    
    /// ECG vital sign type considering its min and max typical measurement value
    let ecg = VitalSignType(name: "ecg", description: "Eletrocardiograma", min: 56, max: 94)
    /// SpO2 vital sign type considering its min and max typical measurement value
    let spo2 = VitalSignType(name: "spo2", description: "Oximetria", min: 91, max: 104)
    /// respiratory frequency vital sign type considering its min and max typical measurement value
    let fr = VitalSignType(name: "fr", description: "Frequência respiratória", min: 11, max: 21)
    /// systolic blood pressure vital sign type considering its min and max typical measurement value
    let pas = VitalSignType(name: "pas", description: "Pressão Arterial Sistólica", min: 101, max: 139)
    /// diastolic blood pressure vital sign type considering its min and max typical measurement value
    let pad = VitalSignType(name: "pad", description: "Pressão Arterial Diastólica", min: 61, max: 94)
    /// temperature vital sign type considering its min and max typical measurement value
    let temp = VitalSignType(name: "temp", description: "Temperatura", min: 35, max: 39)
    
    /// Verifies anomalies into the last vital signs registered to the patients
    @objc override func runAction() {
        let patients = self.parameter as! [Patient]
        
        for patient in patients {
            let vitalSigns = patient.vitalSign

            let ecg = vitalSigns[self.ecg.name]?.last?.value
            let spo2 = vitalSigns[self.spo2.name]?.last?.value
            let fr = vitalSigns[self.fr.name]?.last?.value
            let pas = vitalSigns[self.pas.name]?.last?.value
            let pad = vitalSigns[self.pad.name]?.last?.value
            let temp = vitalSigns[self.temp.name]?.last?.value
            
            var message: String = ""
            
            if (ecg != nil) && !(self.ecg.min...self.ecg.max ~= ecg ?? 0) {
                message = message + "\n ECG irregular: " + String(Int(ecg ?? 0))
            }
            if (spo2 != nil) && !(self.spo2.min...self.spo2.max ~= spo2 ?? 0) {
                message = message + "\n SpO2 irregular: " + String(Int(spo2 ?? 0))
            }
            if (fr != nil) && !(self.fr.min...self.fr.max ~= fr ?? 0) {
                message = message + "\n FR irregular: " + String(Int(fr ?? 0))
            }
            if (pas != nil) && !(self.pas.min...self.pas.max ~= pas ?? 0) {
                message = message + "\n PAS irregular: " + String(Int(pas ?? 0))
            }
            if (pad != nil) && !(self.pad.min...self.pad.max ~= pad ?? 0) {
                message = message + "\n PAD irregular: " + String(Int(pad ?? 0))
            }
            if (temp != nil) && !(self.temp.min...self.temp.max ~= temp ?? 0) {
                message = message + "\n TEMP irregular: " + String(Int(temp ?? 0))
            }
            
            self.result.append((patient: patient, message: message))
        }
    }
}
