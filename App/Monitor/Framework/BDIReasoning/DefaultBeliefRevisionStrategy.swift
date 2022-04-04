//
//  DefaultBeliefRevisionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// DefaultBeliefRevisionStrategy class is a default class of the BeliefRevisionStrategy protocol with the reviewBeliefs function already implemented.
class DefaultBeliefRevisionStrategy: AbstractReasoningStrategy, BeliefRevisionStrategy {
    /// Loops through the beliefs array and reviews it sequentially. checking if there is a data into it.
    /// - parameter beliefs: array of Beliefs to be reviewed
    func reviewBeliefs(beliefs: [Belief]) {
        for belief in beliefs {
            if belief.data != nil {
                belief.available = true
            }
        }
    }
}
