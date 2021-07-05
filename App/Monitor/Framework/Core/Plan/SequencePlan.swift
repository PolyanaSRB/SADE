//
//  SequencePlan.swift
//  Monitor
//
//  Created by user174461 on 2/18/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation

class SequencePlan: Plan {
    override func executePlan(){  //SequencePlan
        // varre o vetor de ações e chama a execução
        //self.status = .executing
        for action in self.actions {
            action.start()
        }
        self.actions = []
        //self.status = .executed
    }
}
