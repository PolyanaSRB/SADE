//
//  Plan.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class Plan { //protocol?
    var name: String
    var goal: Goal
    var priority: Int
    var actions: [Action] = []
    //var status: StatusPlan = StatusPlan.neverExecuted
    
    init(name: String, priority: Int, goal: Goal){
        self.name = name
        self.priority = priority
        self.goal = goal
    }
    
    func addAction(action: Action){
        self.actions.append(action)
    }
    
    func executePlan(){
        print("Implemente executePlan")
    }
}

enum StatusPlan {
    case executed
    case executing
    case neverExecuted
}
