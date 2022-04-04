//
//  Agent.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

/// Agent class represents the Software Agent paradigm.
///
/// Software Agents represent elements situated in some environment to perform autonomous actions and reach their goals. Their main properties are autonomy, learning, proactivity, and communication.
///
/// This class inherits from the Thread class, considering that an agent must be an alive and autonomous entity.
class Agent: Thread {
    /// String to represent the agent name identifier
    var agentName: String
    /// array containing the goals that agent will help to achieve
    var goals: [Goal]
    /// dictionary where the key is the belief name identifier and the value is the environment belief the agent must know to execute its tasks
    var beliefs: [String: Belief]
    /// plans containing actions
    var plans: [Plan]
    /// beliefs revision strategy, the first step of the BDI reasoning
    var beliefRevision: BeliefRevisionStrategy
    /// goals revision strategy, the second step of the BDI reasoning
    var optionGeneration: OptionGenerationStrategy
    /// goals choice strategy, the third step of the BDI reasoning
    var filter: DeliberationStrategy
    /// strategy to choose the plans to be executed, which belong to the chosen goal. The last step of the BDI reasoning
    var planSelection: PlanSelectionStrategy
    /// port address to receive and send messages
    var port: UInt16
    /// Client array containing the addresses of agents with whom the self agent has already communicated
    var clients: [Client] = []
    
    /// - parameter agentName: String to represent the agent name
    /// - parameter goals: array containing the goals that agent will help to achieve
    /// - parameter beliefs: the environment beliefs it must know to execute its tasks
    /// - parameter plans: plans containing actions
    /// - parameter beliefRevision: beliefs revision strategy, the first step of the BDI reasoning
    /// - parameter optionGeneration: goals revision strategy, the second step of the BDI reasoning
    /// - parameter filter: goals choice strategy, the third step of the BDI reasoning
    /// - parameter planSelection: strategy to choose the plans to be executed, which belong to the chosen goal. The last step of the BDI reasoning
    /// - parameter port: port address to receive and send messages
    init(agentName: String, goals: [Goal], beliefs: [String: Belief], plans: [Plan], beliefRevision: BeliefRevisionStrategy, optionGeneration: OptionGenerationStrategy, filter: DeliberationStrategy, planSelection: PlanSelectionStrategy, port: UInt16) {
        self.agentName = agentName
        self.goals = goals
        self.beliefs = beliefs
        self.plans = plans
        self.beliefRevision = beliefRevision
        self.optionGeneration  = optionGeneration
        self.filter = filter
        self.planSelection = planSelection
        self.port = port
        
        super.init()
        
        beliefRevision.setAgent(agent: self)
        optionGeneration.setAgent(agent: self)
        filter.setAgent(agent: self)
        planSelection.setAgent(agent: self)
        
        Environment.environment.agents[self.agentName] = self
        self.createServer(port: port)
    }
    
    /// Creates and starts a Server that contains a listener to stablish a communication channel in the port.
    /// - parameter port: requested port to the server
    func createServer(port: UInt16) {
        let server = Server(port: port, agent: self)
        try! server.start()
    }
    
    /// Inserts a Goal in the agent goals array.
    /// - parameter goal: requested Goal object
    func addGoal(goal: Goal){
        self.goals.append(goal)
    }
    
    /// Inserts a Belief in the agent beliefs dictionary.
    /// - parameter name: a key access to the belief
    /// - parameter belief: requested Belief object
    func addBelief(name: String, belief: Belief){
        self.beliefs[name] = belief
    }
    
    /// Inserts a Plan in the agent plans array.
    /// - parameter plan: requested Plan object
    func addPlan(plan: Plan){
        self.plans.append(plan)
    }
    
    /// Starts the agent as a Thread and runs the BDI cycle (function runBDICycle)
    override func start(){
        super.start()
        runBDICycle()
    }
    
    /// Stops the agent as a Thread
    func stop() {
        self.cancel()
    }
    
    /// Executes the BDI reasoning cycle
    ///
    /// A Belief-Desire-Intention (BDI) reasoning is a philosophical theory of the practical reasoning, explaining the human reasoning through some attitudes: beliefs, desires and intentions.
    ///
    /// It considers four main steps:
    /// 1. beliefs review;
    /// 2. goals (desires) review;
    /// 3. choice of goals to be reached (intentions);
    /// 4. choice of plans to be executed, which belong to the chosen goal.
    @objc func runBDICycle(){
        self.beliefRevision.reviewBeliefs(beliefs: Array(self.beliefs.values))
        self.optionGeneration.reviewGoals(goals: self.goals)
        self.filter.filter(goals: self.goals)
        self.planSelection.selectPlan(plans: self.plans)
        
    }
    
    /// Sends an ACLMessage to an agent localized in the given address (host and port)
    ///
    /// Each message follows the Agent Communication Language (ACL), a set of one or more message parameters, which defines which information each message must contain. Among these parameters are, for example, the type of communicative act, sender, receiver and message content.
    /// - parameter host: requested host of the message receiver
    /// - parameter port: requested port of the message receiver
    /// - parameter message: requested ACLMessage to be sent to host:port
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
