//
//  VitalSignAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class VitalSignAction: AnomaliesAction {
    /*var patient: COVID19Patient
    
    init(patient: COVID19Patient) {
        self.patient = patient
    }*/
    var agent: Agent! = nil
    
    @objc override func runAction() {
        //let patients = self.parameter as! [COVID19Patient]
        super.runAction()
        let patientsMessages = self.result
        let msgTo = self.agent?.beliefs["msgTo"]?.data
        let agentReceiver = Environment.environment.whitePages(agentName: msgTo as! String)
        
        self.agent?.beliefs["patientsWithAnomalies"]?.data = patientsMessages
        
        if !patientsMessages.isEmpty {
            let aclVSmessage = ACLMessage()
            aclVSmessage.performative = .inform
            aclVSmessage.content = "Send alerts!"
            let port = agentReceiver?.port
            self.agent.sendMessage(host: "localhost", port: port!, message: aclVSmessage)
        }
    }
}
