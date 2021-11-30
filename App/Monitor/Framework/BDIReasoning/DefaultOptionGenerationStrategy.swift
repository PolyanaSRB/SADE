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
        for goal in goals {
            // implementar acao para revisar goals
            if goal.status == StatusGoal.waiting {
                
            }
            else if goal.status == StatusGoal.failed {
                
            }
            // return goals waiting primeiro
        }
    }
}
