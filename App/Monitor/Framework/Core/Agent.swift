//
//  Agent.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

class Agent: Thread {
    var agentName: String
    var env: Environment
    var goals: [Goal]
    var beliefs: [String: Belief]
    var plans: [Plan]
    var beliefRevision: BeliefRevisionStrategy
    var optionGeneration: OptionGenerationStrategy
    var filter: DeliberationStrategy
    var planSelection: PlanSelectionStrategy
    var port: UInt16
    var clients: [Client] = []
    
    init(agentName: String, env: Environment, goals: [Goal], beliefs: [String: Belief], plans: [Plan], beliefRevision: BeliefRevisionStrategy, optionGeneration: OptionGenerationStrategy, filter: DeliberationStrategy, planSelection: PlanSelectionStrategy, port: UInt16) {
        self.agentName = agentName
        self.env = env
        self.goals = goals
        self.beliefs = beliefs
        self.plans = plans
        self.beliefRevision = beliefRevision
        self.optionGeneration  = optionGeneration
        self.filter = filter
        self.planSelection = planSelection
        self.port = port
        
        super.init()
        Environment.environment.agents[self.agentName] = self
        self.createServer(port: port)
    }
    
    func createServer(port: UInt16) {
        let server = Server(port: port, agent: self)
        try! server.start()
    }
    
    func addGoal(goal: Goal){
        self.goals.append(goal)
    }
    
    func addBelief(name: String, belief: Belief){
        self.beliefs[name] = belief
    }
    
    func addPlan(plan: Plan){
        self.plans.append(plan)
    }
    
    override func start(){
        super.start()
        runBDICycle()
    }
    
    func stop() {
        self.cancel()
    }
    
    @objc func runBDICycle(){
        self.beliefRevision.reviewBeliefs(beliefs: Array(self.beliefs.values)) //pegar os retornos pra passar pro proximo passo
        self.optionGeneration.reviewGoals(goals: self.goals) // revisa goals vendo os que tem todos os planos ja executados e mudando seu status
        self.filter.filter(goals: self.goals)
        self.planSelection.selectPlan(plans: self.plans)
        
    }
    
    func sendMessage(host:String, port:UInt16, message: ACLMessage) {
        let savedData = try! NSKeyedArchiver.archivedData(withRootObject: message, requiringSecureCoding: false)
        var aux = false
        for client in self.clients {
            if (client.host == NWEndpoint.Host(host)) && (client.port.rawValue == port) {
                aux = true
                client.connection.send(data:savedData)
                break
            }
        }
        if !aux {
            let client = Client(host: host, port: port)
            self.clients.append(client)
            client.start()
            client.connection.send(data: savedData)
        }
    }
}
