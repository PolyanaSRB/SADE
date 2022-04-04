//
//  Goal.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Goal class to represent an agent desire, a goal that an agent should try to achieve.
class Goal {
    /// goal name identifier
    var name: String
    /// dictionary where the key is the execution priority indicator and the value is the plan that must be executed to complete the goal
    var plans: [Int:Plan] = [:]
    /// goal status of execution
    var status: StatusGoal = StatusGoal.waiting
    
    /// - parameter name: goal name identifier
    init(name: String) {
        self.name = name
        Environment.environment.goals.append(self)
    }
}

/// Goal possible statuses
enum StatusGoal {
    /// must be executed
    case execute
    /// successfully executed
    case success
    /// running
    case executing
    /// waiting to be executed
    case waiting
    /// execution failure
    case failed
}
