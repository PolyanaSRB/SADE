//
//  DefaultPlanSelectionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// DefaultPlanSelectionStrategy class is a default class of the PlanSelectionStrategy protocol with the selectPlan function already implemented.
class DefaultPlanSelectionStrategy: AbstractReasoningStrategy, PlanSelectionStrategy {
    /// Loops through the plans array and executes it sequentially, considering three conditions: the status of the Goal related to it; its status; and its not empty Actions array.
    /// - parameter plans: array of Plans to be selected and executed
    func selectPlan(plans: [Plan]) {
        for plan in plans {
            if (plan.goal.status == StatusGoal.execute) && (plan.status == StatusPlan.neverExecuted) && (!plan.actions.isEmpty) {
                plan.status = StatusPlan.executing
                plan.executePlan()
            }
        }
    }
}
