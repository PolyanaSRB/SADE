//
//  OptionGenerationStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// OptionGenerationStrategy protocol models the review of an agent's goals, the second step of the BDI reasoning cycle.
///
/// If one needs to create a OptionGenerationStrategy, this protocol must be extended
protocol OptionGenerationStrategy: ReasoningStrategy {
    /// Reviews a Goal array
    /// - parameter beliefs: array of Goals to be reviewed
    func reviewGoals(goals: [Goal])
}
