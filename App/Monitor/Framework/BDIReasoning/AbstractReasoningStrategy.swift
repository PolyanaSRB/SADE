//
//  AbstractReasoningStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// AbstractReasoningStrategy class is a default class of the ReasoningStrategy protocol with the setAgent function already implemented.
class AbstractReasoningStrategy: ReasoningStrategy {
    /// Agent object that will use the strategy
    var agent: Agent?
    
    /// Relates the strategy with the agent
    /// - parameter agent: the agent that will run the strategy in its BDI reasoning
    func setAgent(agent: Agent) {
        self.agent = agent
    }
    
}
