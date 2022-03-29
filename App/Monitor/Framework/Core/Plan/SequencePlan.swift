//
//  SequencePlan.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class SequencePlan: Plan {
    override func executePlan(){  //SequencePlan
        // varre o vetor de ações e chama a execução
        var newActions: [Action] = []
        
        for action in self.actions {
            if action.testPreCondition() {
                action.start()
                if !action.testPosCondition() {
                    self.status = .fail
                    newActions.append(action)
                }
            }
            else {
                newActions.append(action)
            }
        }
        self.actions = newActions
        
        if (newActions.isEmpty) {
            self.status = .executed
        }
        else if (self.status != .fail) {
            self.status = .neverExecuted // like a 'try again' to the actions that were not executed
        }
    }
}
