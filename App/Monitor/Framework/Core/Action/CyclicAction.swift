//
//  CyclicAction.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

// Class to register a cyclic behavior inheriting from Action protocol. It contains functions to start and stop the cyclic collector and a provided collect function, that should be implemented depending on the data location
class CyclicAction: Action {
    var interval: Double //seconds
    var timer: Timer?
    
    init(interval: Double) {
        self.interval = interval
    }
    
    override func start() {  //no oneshot, vai chamar direto o runAction
        self.timer = Timer.scheduledTimer(timeInterval: self.interval, target: self, selector: #selector(runAction), userInfo: nil, repeats: true)
    }
    
    func stop() {
        self.timer?.invalidate()
    }

    @objc func runAction(){  //antiga collect
        // posCondition chamado aqui dentro
    }
    
    func posCondition() -> Bool{  // varre as condicoes
        // stop para ciclico na poscondition
        return true
    }
}
