//
//  ReasoningStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// ReasoningStrategy protocol to be the base of every strategy of the BDI reasoning cycle
protocol ReasoningStrategy {
    /// Relates the strategy with the agent
    /// - parameter agent: the agent that will run the strategy in its BDI reasoning
    func setAgent(agent: Agent)
}
