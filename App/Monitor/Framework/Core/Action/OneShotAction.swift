//
//  OneShotAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Type of Action class with a default start function already implemented, representing actions that are executed just once by calling the runAction function.
///
/// If a new Action class extends from OneShotAction, it must override runAction function.
class OneShotAction: Action {
    
    /// Starts the action.
    override func start() {
        runAction()
    }
    
    /// Runs the action based on a task. This function must be overriden when this class is extended.
    func runAction(){
        print("Implement your runAction function")
    }
}
