//
//  COVID19Patient.swift
//  Monitor
//
//  Created by user174461 on 7/3/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// My instance Patient class, inheriting from the Framework class Patient added by a new property to control if patient is using a breather
class COVID19Patient : Patient {
    var breath: Bool
    
    init(name: String, cpf: String, phone: String, dateBirth: Date, comorbidity: String, allergy: String, dateEntrance: Date, isMonitored: Bool, breath: Bool) {
        self.breath = breath
        
        super.init(name: name, cpf: cpf, phone: phone, dateBirth: dateBirth, comorbidity: comorbidity, allergy: allergy, dateEntrance: dateEntrance, isMonitored: isMonitored)
    }
}
