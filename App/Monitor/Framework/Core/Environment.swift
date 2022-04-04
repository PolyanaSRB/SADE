//
//  Environment.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import UserNotifications

/// Class to model the Environment as a Singleton design pattern
///
/// Environment class represents the environment into which agents are inserted, beyond perceiving and acting into it. The class contains the main active objects of the framework, so it was modeled as a Singleton design pattern to ensure a single point of access to all of them.
///
/// As it is a Singleton, the Environment is already started along with the instance's initialization. Then just register the objects. The framework provides for the registration of agents and goals - as goals contain plans and plans contain actions, all the main objects will already be registered directly or indirectly in the environment.
class Environment {
    /// auto-declaration of the environment considering it as a singleton
    static let environment = Environment()
    /// environment name
    var name: String = ""
    /// dictionary where the key is the agent name and the value is the agent, for agents belonging to the environment
    var agents: [String:Agent] = [:]
    /// goals belonging to the environment
    var goals: [Goal] = []
    
    private init(){}
    
    /// White pages service to search for a software agent by its name
    /// - parameter agentName: agent name to be found in the environment
    func whitePages(agentName: String) -> Agent? {
        if let agent = agents[agentName] {
            return agent
        } else {
            return nil
        }
    }
    
    /// Stops all agents registered in the environment
    func stop(){
        for agent in agents {
            agent.value.stop()
        }
    }
}
