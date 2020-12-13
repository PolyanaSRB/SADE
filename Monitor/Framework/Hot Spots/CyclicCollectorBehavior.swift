//
//  CyclicCollectorBehavior.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to register a cyclic behavior inheriting from CollectorBehavior protocol. It contains functions to start and stop the cyclic collector and a provided collect function, that should be implemented depending on the data location
class CyclicCollectorBehavior : CollectorBehavior {
    var interval: Double //seconds
    var timer: Timer?
    
    init(interval: Double) {
        self.interval = interval
    }
    
    func start() {
        self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(collect), userInfo: nil, repeats: true)
    }
    
    func stop() {
        self.timer?.invalidate()
    }
    
    @objc func collect() {
        print("Implemente sua função CyclicCollect!")
    }
    
}
