//
//  AlertAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
//import UIKit
import UserNotifications

class AlertAction: OneShotAction {
    var agent: Agent!
    
    @objc override func runAction() {
        let patientsWithAnomalies = self.agent.beliefs["patientsWithAnomalies"]?.data as! [(patient: Patient, message: String)]
        
        for patientMessage in patientsWithAnomalies {
            let patient = patientMessage.patient
            let message = patientMessage.message
            
            if message != "" {
                print(patient.name, message)
                COVID19UsefulData.shared.alert = COVID19UsefulData.shared.alert + message
                
                scheduleNotification(title: patient.name, message: message)
            }
        }
        self.agent.beliefs["patientsWithAnomalies"]?.data = []
    }
    
    func scheduleNotification(title: String, message: String) {
        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
        
    }

}
