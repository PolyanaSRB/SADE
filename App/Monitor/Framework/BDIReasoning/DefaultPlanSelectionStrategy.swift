//
//  DefaultPlanSelectionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class DefaultPlanSelectionStrategy: AbstractReasoningStrategy, PlanSelectionStrategy {
    func selectPlan(plans: [Plan]) {
        // implements function selectPlan - selecionar plano, dentro de um conjunto de planos dados, que sera executado para alcancar um goal dado - definir a estrategia de selecao (primeiro da lista? aleatoria?)
        for plan in plans {
            if (plan.goal.status == StatusGoal.execute) && (plan.status == StatusPlan.neverExecuted) && (!plan.actions.isEmpty) {
                plan.status = StatusPlan.executing
                plan.executePlan()
            }
        }
    }
}
