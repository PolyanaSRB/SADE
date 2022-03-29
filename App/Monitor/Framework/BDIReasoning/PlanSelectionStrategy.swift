//
//  PlanSelectionStrategy.swift
//  Monitor
//
//  Created by user174461 on 6/9/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

protocol PlanSelectionStrategy: ReasoningStrategy {
    func selectPlan(plans: [Plan])
}
