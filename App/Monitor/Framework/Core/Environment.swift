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
    static let environment = Environment() //name: "VSmonitor"
    
    var name: String = ""
    var agents: [String:Agent] = [:]
    var beliefs: [Belief] = []
    var plans: [Plan] = []
    //var center: UNUserNotificationCenter = UNUserNotificationCenter.current()
    
    private init(){}
    /*private init(name: String){
        self.name = name
    }*/
    
    func start() {  // coisas da instancia nao podem ficar aqui - criar o environment da instancia e colocar tudo isso
        Environment.environment.name = "VSmonitor"

        //set goals
        let collectGoal = Goal(name: "CollectGoal") //, status: false)
        let vitalSignGoal = Goal(name: "VitalSignGoal") //, status: false)
        let alertGoal = Goal(name: "AlertGoal") //, status: false)
        
        // set actions
        let collectAction = CollectorAction(interval: 5)
        //var actionsVitalSign: [VitalSignAction] = []
        //var alertAction: [AlertAction] = []
        
        //set plans
        let collectPlan = SequencePlan(name: "CollectPlan", priority: 0, goal: collectGoal)
        collectPlan.actions.append(collectAction)
        let vitalSignPlan = SequencePlan(name: "VitalSignPlan", priority: 0, goal: vitalSignGoal)
        let alertPlan = SequencePlan(name: "AlertPlan", priority: 0, goal: alertGoal)
        
        Environment.environment.plans = [collectPlan, vitalSignPlan, alertPlan]

        //set belief revisions
        let collectorBeliefRevision = DefaultBeliefRevisionStrategy()
        let vitalSignBeliefRevision = DefaultBeliefRevisionStrategy()
        let alertBeliefRevision = DefaultBeliefRevisionStrategy()
        
        //set option generations
        let collectorOptionGener = DefaultOptionGenerationStrategy()
        let vitalSignOptionGener = DefaultOptionGenerationStrategy()
        let alertOptionGener = DefaultOptionGenerationStrategy()
        
        //set filter
        let collectorFilter = DefaultDeliberationStrategy()
        let vitalSignFilter = DefaultDeliberationStrategy()
        let alertFilter = DefaultDeliberationStrategy()
        
        //set agents
        let collectorAgent = Agent(name: "CollectorAgent", env: Environment.environment, goals: [collectGoal], beliefs: [], plans: [collectPlan], beliefRevision: collectorBeliefRevision, optionGeneration: collectorOptionGener, filter: collectorFilter)
        collectorBeliefRevision.setAgent(agent: collectorAgent)
        collectorOptionGener.setAgent(agent: collectorAgent)
        collectorFilter.setAgent(agent: collectorAgent)
        
        let vitalSignAgent = Agent(name: "VitalSignAgent", env: Environment.environment, goals: [vitalSignGoal], beliefs: [], plans: [vitalSignPlan], beliefRevision: vitalSignBeliefRevision, optionGeneration: vitalSignOptionGener, filter: vitalSignFilter)
        vitalSignBeliefRevision.setAgent(agent: vitalSignAgent)
        vitalSignOptionGener.setAgent(agent: vitalSignAgent)
        vitalSignFilter.setAgent(agent: vitalSignAgent)
        
        let alertAgent = Agent(name: "AlertAgent", env: Environment.environment, goals: [alertGoal], beliefs: [], plans: [alertPlan], beliefRevision: alertBeliefRevision, optionGeneration: alertOptionGener, filter: alertFilter)
        alertBeliefRevision.setAgent(agent: alertAgent)
        alertOptionGener.setAgent(agent: alertAgent)
        alertFilter.setAgent(agent: alertAgent)
        
        Environment.environment.agents = ["CollectorAgent": collectorAgent, "VitalSignAgent": vitalSignAgent, "AlertAgent": alertAgent]
        
        collectorAgent.start()
        vitalSignAgent.start()
        alertAgent.start()
        
        
    }
    
    func stop(){
        for agent in agents {
            agent.value.stop()
        }
        print(COVID19UsefulData.shared.alert)
    }
    
}

//Access class function in a single line
// COVID19UsefulData.shared.requestForLocation()
// COVID19UsefulData.shared.hospital
//*/
