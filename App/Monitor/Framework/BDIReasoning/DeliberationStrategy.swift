//
//  DeliberationStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// DeliberationStrategy protocol models the deliberation step of the BDI reasoning cycle. This third step must filter a set of goals and selects a subset to be tried and turned into intentions.
///
/// If one needs to create a DeliberationStrategy, this protocol must be extended.
protocol DeliberationStrategy: ReasoningStrategy {
    /// Filters a set of goals and turns it into intentions
    /// - parameter goals: array of Goals to be filtered
    func filter(goals: [Goal])
}
