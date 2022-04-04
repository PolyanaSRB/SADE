//
//  Plan.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Plan class to represent an agent intention, which wil be executed when the agent attempts to achieve the related goal
///
/// This class must be extended to create your own Plan class with your action execution strategy
class Plan {
    /// plan name identifier
    var name: String
    /// related goal
    var goal: Goal
    /// actions that must be executed to conclude the plan
    var actions: [Action] = []
    /// plan status of execution
    var status: StatusPlan = StatusPlan.neverExecuted
    
    /// - parameter name: plan name identifier
    /// - parameter goal: related goal
    init(name: String, goal: Goal){
        self.name = name
        //self.priority = priority
        self.goal = goal
    }
    
    /// Adds an action to the array of actions
    /// - parameter action: action object to be included
    func addAction(action: Action){
        self.actions.append(action)
    }
    
    /// Executes the actions related to the plan according to some pre-defined strategy. This function must be overridden when this class is extended.
    func executePlan(){
        print("Implement executePlan")
    }
}

/// Plan possible statuses
enum StatusPlan {
    /// successfully executed
    case executed
    /// running
    case executing
    /// waiting to be executed
    case neverExecuted
    /// execution failure
    case fail
}
