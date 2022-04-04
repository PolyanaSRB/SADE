//
//  CyclicAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

/// Type of Action class with a default start function already implemented, representing actions that are executed in run loops by calling the runAction function.
///
/// If a new Action class extends from CyclicAction, it must override runAction function.
class CyclicAction: Action {
    /// time interval in seconds between each call
    var interval: Double
    /// a Timer object to fire after a certain time interval has elapsed
    var timer: Timer?
    
    /// - parameter interval: interval in seconds between each call
    init(interval: Double) {
        self.interval = interval
    }
    
    /// Starts the Timer to execute the runAction function in run loops considering the time interval in seconds
    override func start() {
        self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(runAction), userInfo: nil, repeats: true)
    }
    
    /// Invalidates the timer
    func stop() {
        self.timer?.invalidate()
    }

    /// Runs the action based on a task. This function must be overriden when this class is extended
    @objc func runAction(){
        print("Implement your runAction function")
    }
}
