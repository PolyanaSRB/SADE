//
//  DefaultOptionGenerationStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class DefaultOptionGenerationStrategy: AbstractReasoningStrategy, OptionGenerationStrategy {
    func reviewGoals(goals: [Goal]) {
        // implement function reviewGoals - analisar goals que ainda nao foram alcancados e escolher aqueles a serem eliminados e talvez gerar novos goals
        //print("option generation")
        for goal in goals {
            // implementar acao para revisar goals
            var flag = true
            for plan in goal.plans.values {
                //print(plan.status)
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
            //print(flag)
            if flag {
                goal.status = StatusGoal.success
            }
            
            // return goals waiting primeiro
        }
    }
}
