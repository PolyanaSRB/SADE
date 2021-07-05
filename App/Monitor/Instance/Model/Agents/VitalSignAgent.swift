//
//  VitalSignAgent.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class VitalSignAgent: Agent {
    var patient: COVID19Patient
    
    init(name: String, env: Environment, goals: [Goal], beliefs: [Belief], plans: [Plan], patient: COVID19Patient) {
        self.patient = patient
        
        super.init(name: name, env: env, goals: goals, beliefs: beliefs, plans: plans)
    }
}
