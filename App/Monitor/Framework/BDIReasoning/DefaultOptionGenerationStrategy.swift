//
//  DefaultOptionGenerationStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// DefaultOptionGenerationStrategy class is a default class of the OptionGenerationStrategy protocol with the reviewGoals function already implemented.
class DefaultOptionGenerationStrategy: AbstractReasoningStrategy, OptionGenerationStrategy {
    /// Loops through the goals array and reviews it sequentially, updating its status.
    /// - parameter goals: array of Goals to be reviewed
    func reviewGoals(goals: [Goal]) {
        for goal in goals {
            var flag = true
            for plan in goal.plans.values {
                if plan.status == StatusPlan.neverExecuted {
                    goal.status = StatusGoal.waiting
                    flag = false
                    break
                }
                if plan.status == StatusPlan.executing {
                    goal.status = StatusGoal.executing
                    flag = false
                    break
                }
            }
            if flag {
                goal.status = StatusGoal.success
            }
        }
    }
}
