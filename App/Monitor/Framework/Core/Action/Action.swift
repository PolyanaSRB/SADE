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
    
    func start() {
        print("Implemente sua função start")
    }
}
