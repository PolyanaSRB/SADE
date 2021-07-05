//
//  COVID19UsefulData.swift
//  Monitor
//
//  Created by user174461 on 7/3/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to model a Singleton, a creational design pattern to provide a single point to access useful data
class COVID19UsefulData{
    static let shared = COVID19UsefulData()
    
    var healthCareWorker: HealthCareWorker?
    var hospital: Hospital?
    var patients: [COVID19Patient] = []
    
    let ecg = VitalSignType(name: "ecg", description: "Eletrocardiograma", min: 56, max: 94)
    let spo2 = VitalSignType(name: "spo2", description: "Oximetria", min: 91, max: 104)
    let fr = VitalSignType(name: "fr", description: "Frequência respiratória", min: 11, max: 21)
    let pas = VitalSignType(name: "pas", description: "Pressão Arterial Sistólica", min: 101, max: 139)
    let pad = VitalSignType(name: "pad", description: "Pressão Arterial Diastólica", min: 61, max: 94)
    let temp = VitalSignType(name: "temp", description: "Temperatura", min: 35, max: 39)
    
    var behavior: CyclicAction?
    
    var alert: String = ""
    
    private init(){}
    
}

//Access class function in a single line
// COVID19UsefulData.shared.requestForLocation()
// COVID19UsefulData.shared.hospital
//*/
