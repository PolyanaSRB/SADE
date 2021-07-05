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
    
    init(name: String, env: Environment, goals: [Goal], beliefs: [Belief], plans: [Plan]) {
        self.name = name
        self.env = env
        self.goals = goals
        self.beliefs = beliefs
        self.plans = plans
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
        self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(runPlans), userInfo: nil, repeats: true)
    }
    
    func stop() {
        self.timer?.invalidate()
    }
    
    @objc func runPlans(){
        /*for plan in self.plans{
            if plan.status == .executing {
                return
            }
        }*/
        for plan in self.plans {
            if !plan.goal.status {
                //&& plan.status == .neverExecuted {
                plan.executePlan()
            }
        }
    }
}
