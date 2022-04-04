//
//  Action.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Action class to represent a task that must be executed by the agent to conclude a plan.
///
/// This class must be extended to create your own Action class overriding start function.
class Action {
    /// parameter needed to perform the action
    var parameter: AnyObject?
    /// conditions that must be verified before the execution of the action
    var preCondition: [Condition] = []
    /// conditions that mus be verified after the execution of the action
    var posCondition: [Condition] = []
    
    /// Verifies the preconditions and returns a boolean to inform if they were confirmed.
    func preConditionAnalysis() -> Bool {
        var flag = true
        if !self.preCondition.isEmpty {
            for condition in self.preCondition {
                if !condition.conditionAnalysis() {
                    flag = false
                }
            }
        }
        return flag
    }
    
    /// Verifies the posconditions and returns a boolean to inform if they were confirmed.
    func posConditionAnalysis() -> Bool {
        var flag = true
        if !self.posCondition.isEmpty {
            for condition in self.posCondition {
                if !condition.conditionAnalysis() {
                    flag = false
                }
            }
        }
        return flag
    }
    
    /// Starts the action. This function must be overriden when this class is extended.
    func start() {
        print("Implement your start function")
    }
}
