//
//  PlanSelectionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// PlanSelectionStrategy protocol models the execution of the plans to reach a specific goal, selected in the deliberation step of the BDI reasoning cycle.
///
/// If one needs to create a PlanSelectionStrategy, this protocol must be extended
protocol PlanSelectionStrategy: ReasoningStrategy {
    /// Selects the plans and determines how they will be executed
    /// - parameter plans: array of Plans to be selected and executed
    func selectPlan(plans: [Plan])
}
