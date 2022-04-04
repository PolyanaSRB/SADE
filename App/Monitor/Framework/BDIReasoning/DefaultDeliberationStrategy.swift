//
//  DefaultDeliberationStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// DefaultDeliberationStrategy class is a default class of the DeliberationStrategy protocol with the filter function already implemented.
class DefaultDeliberationStrategy: AbstractReasoningStrategy, DeliberationStrategy {
    /// Filters a set of goals and turns it into intentions by turning the ones with statuses waiting to execute.
    /// - parameter goals: array of Goals to be filtered
    func filter(goals: [Goal]) {
        for goal in goals {
            if goal.status == StatusGoal.waiting {
                goal.status = StatusGoal.execute
            }
        }
    }
}
