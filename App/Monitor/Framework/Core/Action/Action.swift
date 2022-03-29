//
//  Action.swift
//  Monitor
//
//  Created by user174461 on 2/17/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class Action {
    var parameter: AnyObject?
    var preCondition: [Condition] = []
    var posCondition: [Condition] = []
    
    /*init(parameter: AnyObject?, preCondition: [Condition?], posCondition: [Condition?]) {
        
    }*/
    // TODO tirar test e colocar outro nome - analyze
    func testPreCondition() -> Bool {
        var flag = true
        if !self.preCondition.isEmpty {
            for condition in self.preCondition {
                if !condition.testCondition() {
                    flag = false
                }
            }
        }
        return flag
    }
    
    func testPosCondition() -> Bool {
        var flag = true
        if !self.posCondition.isEmpty {
            for condition in self.posCondition {
                if !condition.testCondition() {
                    flag = false
                }
            }
        }
        return flag
    }
    
    func start() {
        print("Implemente sua função start")
    }
}
