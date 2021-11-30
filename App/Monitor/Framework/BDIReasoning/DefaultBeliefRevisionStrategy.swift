//
//  DefaultBeliefRevisionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class DefaultBeliefRevisionStrategy: AbstractReasoningStrategy, BeliefRevisionStrategy {
    
    func reviewBeliefs(beliefs: [Belief]) {
        // implement function reviewBeliefs - revisar os beliefs da base de beliefs do agente/capability, checando inconsistencias, associando timestamp, ...
        for belief in beliefs {
            // implementar acao para revisar beliefs
            // is available?
                // return availables?
        }
    }
}
