//
//  DefaultDeliberationStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class DefaultDeliberationStrategy: AbstractReasoningStrategy, DeliberationStrategy {
    func filter(goals: [Goal]) {
        // implements function filter - transformar desejos (goals) em intencoes - selecionar subconjunto de goals que devem ser tentados (intencoes) do conjunto de goals - os nao selecionados tem seu status setado pra waiting
        for goal in goals {
            if goal.status == StatusGoal.waiting {
                // implementar condicao para que seja executado e condicao para que saia de execute para waiting
                goal.status = StatusGoal.execute
            }
        }
    }
}
