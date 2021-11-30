//
//  Agent.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

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
    
    init(name: String, env: Environment, goals: [Goal], beliefs: [Belief], plans: [Plan], beliefRevision: BeliefRevisionStrategy, optionGeneration: OptionGenerationStrategy, filter: DeliberationStrategy) {
        self.name = name
        self.env = env
        self.goals = goals
        self.beliefs = beliefs
        self.plans = plans
        self.beliefRevision = beliefRevision
        self.optionGeneration  = optionGeneration
        self.filter = filter
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
}
