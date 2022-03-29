//
//  Environment.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import UserNotifications

// Class to model the Environment as a Singleton design pattern
class Environment {
    static let environment = Environment()
    // name, agents, goals do ambiente
    var name: String = ""
    var agents: [String:Agent] = [:]
    var goals: [Goal] = []
    
    private init(){}
    
    func whitePages(agentName: String) -> Agent? {
        if let agent = agents[agentName] {
            return agent
        } else {
            return nil
        }
    }
    func stop(){
        for agent in agents {
            agent.value.stop()
        }
    }
}

//Access class function in a single line
// COVID19UsefulData.shared.requestForLocation()
// COVID19UsefulData.shared.hospital
//*/
