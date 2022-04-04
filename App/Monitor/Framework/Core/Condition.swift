//
//  Condition.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Condition protocol to represent a condition to execute an action or to verify after the action execution.
///
/// This protocol must be extended to create your own condition class with a conditionAnalysis function.
protocol Condition {
    /// Parses pre or post conditions of execution of some Action and returns a boolean
    func conditionAnalysis() -> Bool
}
