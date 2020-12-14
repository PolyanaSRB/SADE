//
//  Agent.swift
//  Monitor
//
//  Created by user174461 on 7/1/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to create and start a software agent responsible for controlling new data collection, considering a cyclic behavior
class Agent: Thread {
    
    static func addBehavior(behavior: CyclicCollectorBehavior){
        print("Behavior added")
        behavior.start()
        COVID19UsefulData.shared.behavior = behavior
        
    }
}
