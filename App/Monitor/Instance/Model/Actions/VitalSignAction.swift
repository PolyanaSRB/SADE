//
//  VitalSignAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class VitalSignAction: OneShotAction {
    /*var patient: COVID19Patient
    
    init(patient: COVID19Patient) {
        self.patient = patient
    }*/
    
    @objc override func runAction() {
        let patient = self.parameter as! COVID19Patient
        let usefulDataVS = COVID19UsefulData.shared
        
        let ecg = patient.vitalSign[usefulDataVS.ecg.name]?.last?.value
        let spo2 = patient.vitalSign[usefulDataVS.spo2.name]?.last?.value
        let fr = patient.vitalSign[usefulDataVS.fr.name]?.last?.value
        let pas = patient.vitalSign[usefulDataVS.pas.name]?.last?.value
        let pad = patient.vitalSign[usefulDataVS.pad.name]?.last?.value
        let temp = patient.vitalSign[usefulDataVS.temp.name]?.last?.value
        
        var message: String = ""
        
        if (ecg != nil) && !(usefulDataVS.ecg.min...usefulDataVS.ecg.max ~= ecg ?? 0) {
            message = message + "\n ECG irregular: " + String(Int(ecg ?? 0))
        }
        if (spo2 != nil) && !(usefulDataVS.spo2.min...usefulDataVS.spo2.max ~= spo2 ?? 0) {
            message = message + "\n SpO2 irregular: " + String(Int(spo2 ?? 0))
        }
        if (fr != nil) && !(usefulDataVS.fr.min...usefulDataVS.fr.max ~= fr ?? 0) {
            message = message + "\n FR irregular: " + String(Int(fr ?? 0))
        }
        if (pas != nil) && !(usefulDataVS.pas.min...usefulDataVS.pas.max ~= pas ?? 0) {
            message = message + "\n PAS irregular: " + String(Int(pas ?? 0))
        }
        if (pad != nil) && !(usefulDataVS.pad.min...usefulDataVS.pad.max ~= pad ?? 0) {
            message = message + "\n PAD irregular: " + String(Int(pad ?? 0))
        }
        if (temp != nil) && !(usefulDataVS.temp.min...usefulDataVS.temp.max ~= temp ?? 0) {
            message = message + "\n TEMP irregular: " + String(Int(temp ?? 0))
        }
        
        let alertAction = AlertAction()
        alertAction.parameter = (patient, message) as AnyObject
        Environment.environment.agents["AlertAgent"]?.plans[0].actions.append(alertAction)
        
        
    }
}
