//
//  ACLMessage.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation

class ACLMessage: NSObject, NSCoding {
    var performative: Performative!
    var sender: Agent!
    var receiver: Agent!
    var replyTo: Agent!
    var content: String!
    var language: String!
    var encoding: String!
    var ontology: String!
    var protocol_: String! //AQUI
    var conversationId: Int!
    var replyWith: String!
    var inReplyTo: String!
    var replyBy: TimeInterval!
    
    override init() {
        super.init()
    }

    required init(coder aDecoder: NSCoder) {

        if let performative = aDecoder.decodeObject(forKey: "performative") as? Performative {
            self.performative = performative
        }

        if let sender = aDecoder.decodeObject(forKey: "sender") as? Agent {
            self.sender = sender
        }
        
        if let receiver = aDecoder.decodeObject(forKey: "receiver") as? Agent {
            self.receiver = receiver
        }
        
        if let replyTo = aDecoder.decodeObject(forKey: "replyTo") as? Agent {
            self.replyTo = replyTo
        }
        
        if let content = aDecoder.decodeObject(forKey: "content") as? String {
            self.content = content
        }
        
        if let language = aDecoder.decodeObject(forKey: "language") as? String {
            self.language = language
        }
        
        if let encoding = aDecoder.decodeObject(forKey: "encoding") as? String {
            self.encoding = encoding
        }
        
        if let ontology = aDecoder.decodeObject(forKey: "ontology") as? String {
            self.ontology = ontology
        }
        
        if let protocol_ = aDecoder.decodeObject(forKey: "protocol_") as? String {
            self.protocol_ = protocol_
        }
        
        if let conversationId = aDecoder.decodeObject(forKey: "conversationId") as? Int {
            self.conversationId = conversationId
        }
        
        if let replyWith = aDecoder.decodeObject(forKey: "replyWith") as? String {
            self.replyWith = replyWith
        }
        
        if let inReplyTo = aDecoder.decodeObject(forKey: "inReplyTo") as? String {
            self.inReplyTo = inReplyTo
        }
        
        if let replyBy = aDecoder.decodeObject(forKey: "replyBy") as? TimeInterval {
            self.replyBy = replyBy
        }
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(performative, forKey: "performative")
        aCoder.encode(sender, forKey: "sender")
        aCoder.encode(receiver, forKey: "receiver")
        aCoder.encode(replyTo, forKey: "replyTo")
        aCoder.encode(content, forKey: "content")
        aCoder.encode(language, forKey: "language")
        aCoder.encode(encoding, forKey: "encoding")
        aCoder.encode(ontology, forKey: "ontology")
        aCoder.encode(protocol_, forKey: "protocol_")
        aCoder.encode(conversationId, forKey: "conversationId")
        aCoder.encode(replyWith, forKey: "replyWith")
        aCoder.encode(inReplyTo, forKey: "inReplyTo")
        aCoder.encode(replyBy, forKey: "replyBy")
    }

}

enum Performative {
    case acceptProposal
    case agree
    case cancel
    case callProposal
    case confirm
    case disconfirm
    case failure
    case inform
    case informIf
    case informRef
    case notUnderstood
    case propagate
    case propose
    case proxy
    case queryIf
    case queryRef
    case refuse
    case rejectProposal
    case request
    case requestWhen
    case requestWhenever
    case subscribe
}
