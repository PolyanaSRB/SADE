//
//  OneShotAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class OneShotAction: Action {
    
    override func start() {
        runAction() //vai ficar na Action geral
    }
    
    func runAction(){  //antiga collect
        
    }
    
    func posCondition() -> Bool{  // varre as condicoes
        return true
    }
}
