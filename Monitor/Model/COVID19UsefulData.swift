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
    
    let ecg = VitalSignType(name: "ecg", description: "Eletrocardiograma")
    let spo2 = VitalSignType(name: "spo2", description: "Oximetria")
    let fr = VitalSignType(name: "fr", description: "Frequência respiratória")
    let pas = VitalSignType(name: "pas", description: "Pressão Arterial Sistólica")
    let pad = VitalSignType(name: "pad", description: "Pressão Arterial Diastólica")
    let temp = VitalSignType(name: "temp", description: "Temperatura")
    
    var behavior: CyclicCollectorBehavior?
    
    private init(){}
    
}

//Access class function in a single line
// COVID19UsefulData.shared.requestForLocation()
// COVID19UsefulData.shared.hospital
//*/
