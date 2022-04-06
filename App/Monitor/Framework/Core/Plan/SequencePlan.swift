//
//  SequencePlan.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Type of Plan class with a default executePlan function already implemented, which executes the actions of a plan in sequence
class SequencePlan: Plan {
    /// Loops through the actions array and executes it in the order it appears
    override func executePlan(){
        var newActions: [Action] = []
        
        for action in self.actions {
            if action.preConditionAnalysis() {
                action.start()
                if !action.posConditionAnalysis() {
                    self.status = .fail
                    newActions.append(action)
                }
            }
            else {
                newActions.append(action)
            }
        }
        //self.actions = newActions
        
        /*if (newActions.isEmpty) {
            self.status = .neverExecuted //.executed
        }*/
        if (self.status != .fail) {
            self.status = .neverExecuted // like a 'try again' to the actions that were not executed
        }
    }
}
