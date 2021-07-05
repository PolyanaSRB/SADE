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
    
    @objc override func runAction() {
        let (patient, message) = self.parameter as! (COVID19Patient, String)
        
        if message != "" {
            print(patient.name, message)
            COVID19UsefulData.shared.alert = COVID19UsefulData.shared.alert + message
            
            scheduleNotification(title: patient.name, message: message)

        }
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
