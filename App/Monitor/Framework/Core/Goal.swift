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
    //var plans: [Int:[Plan]]
    // var action: Action
    //var preCondition: Condition
    //var posCondition: Condition
    // var status: Bool
    var status: StatusGoal = StatusGoal.waiting
    
    init(name: String) { /*plans: [Int:[Plan]], preCondition: Condition, posCondition: Condition, status: Bool) {*/
        self.name = name
        //self.plans = plans
        //self.preCondition = preCondition
        //self.posCondition = posCondition
        // self.status = status
    }
}

enum StatusGoal {
    case execute
    case executed
    case executing
    case waiting
    case failed
}
