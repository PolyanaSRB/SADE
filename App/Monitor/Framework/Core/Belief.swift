//
//  Belief.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Belief class to represent the knowledge of an agent about the environment. It can be anything the agent must know to perform its tasks.
class Belief {
    /// belief information
    var data: Any?
    /// belief availability
    var available: Bool = false
    
    /// If an operation with the belief is desired, it must be implemented
    func operation(){}
}
