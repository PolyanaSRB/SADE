//
//  BeliefRevisionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// BeliefRevisionStrategy protocol models the review of an agent's beliefs, the first step of the BDI reasoning cycle.
///
/// If one needs to create a BeliefRevisionStrategy, this protocol must be extended
protocol BeliefRevisionStrategy: ReasoningStrategy {
    /// Reviews a Belief array
    /// - parameter beliefs: array of Beliefs to be reviewed
    func reviewBeliefs(beliefs: [Belief])
}
