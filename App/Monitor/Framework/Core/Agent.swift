//
//  Agent.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

class Agent {
    var name: String  // {get set}
    var env: Environment
    var goals: [Goal]
    var beliefs: [Belief]
    var plans: [Plan]
    var interval: Double = 1
    var timer: Timer?
    var beliefRevision: BeliefRevisionStrategy
    var optionGeneration: OptionGenerationStrategy
    var filter: DeliberationStrategy
    var server: Server //TODO passar apenas porta
    var clients: [Client] = []
    
    init(name: String, env: Environment, goals: [Goal], beliefs: [Belief], plans: [Plan], beliefRevision: BeliefRevisionStrategy, optionGeneration: OptionGenerationStrategy, filter: DeliberationStrategy, server: Server) { //}, server: Socket, client: Socket) {
        self.name = name
        self.env = env
        self.goals = goals
        self.beliefs = beliefs
        self.plans = plans
        self.beliefRevision = beliefRevision
        self.optionGeneration  = optionGeneration
        self.filter = filter
        self.server = server
        
        try! self.server.start()
    }
    
    func addGoal(goal: Goal){
        self.goals.append(goal)
    }
    
    func addBelief(belief: Belief){
        self.beliefs.append(belief)
    }
    
    func addPlan(plan: Plan){
        self.plans.append(plan)
    }
    
    func start(){
        self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(runBDICycle), userInfo: nil, repeats: true) // posso invalidar o timer e colocar um tempo maior, se necessarios (caso os planos nao tenham acabado de executar, por exemplo
    }
    
    func stop() {
        self.timer?.invalidate()
    }
    
    @objc func runBDICycle(){
        /*for plan in self.plans{
            if plan.status == .executing {
                return
            }
        }*/
        self.beliefRevision.reviewBeliefs(beliefs: self.beliefs) //pegar os retornos pra passar pro proximo passo
        self.optionGeneration.reviewGoals(goals: self.goals)
        self.filter.filter(goals: self.goals)
        
        runPlans()
        
    }
    
    func runPlans(){  // default plan selection strategy (sequence)
        for plan in self.plans {
            if plan.goal.status == StatusGoal.execute {
                //&& plan.status == .neverExecuted {
                plan.goal.status = StatusGoal.executing // goal e plan estao 1 pra 1 - plan com status e em reviewGoals, verificar se todos os planos do goal estao success
                plan.executePlan()
                plan.goal.status = StatusGoal.success
            }
        }
        
    }
    
    func sendMessage(host:String, port:UInt16, message: ACLMessage) { // como passar ACLMessage? a funcao send do Network tem parametro `Data?`
        // criar propriedade de array de clients. aqui passar pelo array pra ver se j[a tem um client com essa conexao
        // client: [Client]
        //cria Client e send message
        //let savedData = NSKeyedArchiver.archivedData(withRootObject: message)
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
