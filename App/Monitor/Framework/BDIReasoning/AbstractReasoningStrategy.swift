//
//  AbstractReasoningStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class AbstractReasoningStrategy: ReasoningStrategy {
    var agent: Agent?
    
    func setAgent(agent: Agent) {
        // implement function setAgent
        self.agent = agent
    }
    
}
