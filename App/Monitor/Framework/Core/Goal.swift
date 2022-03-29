//
//  Goal.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class Goal {
    var name: String
    var plans: [Int:Plan] = [:]
    var status: StatusGoal = StatusGoal.waiting
    
    init(name: String) {
        self.name = name
    }
}

enum StatusGoal {
    case execute
    case success
    case executing
    case waiting
    case failed
}
