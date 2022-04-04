//
//  ACLMessage.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation

/// ACLMessage class represents messages sent from one agent to another. Each message follows the Agent Communication Language (ACL), a set of one or more message parameters, which defines which information each message must contain. Among these parameters are, for example, the type of communicative act (performative), sender, receiver and message content.
class ACLMessage: NSObject, NSCoding {
    /// type of the communicative act
    var performative: Performative!
    /// identity of the sender
    var sender: Agent!
    /// identity of the intended recipients
    var receiver: Agent!
    /// indicates that subsequent messages in this conversation thread are to be directed to the replyTo agent
    var replyTo: Agent!
    /// content of the message
    var content: String!
    /// language in which the content parameter is expressed
    var language: String!
    /// specific encoding of the content language expression
    var encoding: String!
    /// ontology(s) used to give a meaning to the symbols in the content expression
    var ontology: String!
    /// interaction protocol that the sending agent is employing with this ACL message
    var protocol_: String!
    /// expression (a conversation identifier) which is used to identify the ongoing sequence of communicative acts that together form a conversation
    var conversationId: Int!
    /// expression that will be used by the responding agent to identify this message
    var replyWith: String!
    /// expression that references an earlier action to which this message is a reply
    var inReplyTo: String!
    /// time and/or date expression which indicates the latest time by which the sending agent would like to receive a reply
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

/// ACLMessage possible performatives
enum Performative {
    /// the action of accepting a previously submitted proposal to perform an action
    case acceptProposal
    /// the action of agreeing to perform some action, possibly in the future
    case agree
    /// the action of one agent informing another agent that the first agent no longer has the intention that the second agent performs some action
    case cancel
    /// the action of calling for proposals to perform a given action
    case callProposal
    /// the sender informs the receiver that a given proposition is true, where the receiver is known to be uncertain about the proposition
    case confirm
    /// the sender informs the receiver that a given proposition is false, where the receiver is known to believe, or believe it likely that, the proposition is true
    case disconfirm
    /// the action of telling another agent that an action was attempted but the attempt failed
    case failure
    /// the sender informs the receiver that a given proposition is true
    case inform
    /// a macro action for the agent of the action to inform the recipient whether or not a proposition is true
    case informIf
    /// a macro action for sender to inform the receiver the object which corresponds to a descriptor, for example, a name
    case informRef
    /// the sender of the act (for example, i) informs the receiver (for example, j) that it perceived that j performed some action, but that i did not understand what j just did. A particular common case is that i tells j that i did not understand the message that j has just sent to i
    case notUnderstood
    /// the sender intends that the receiver treat the embedded message as sent directly to the receiver, and wants the receiver to identify the agents denoted by the given descriptor and send the received propagate message to them
    case propagate
    /// the action of submitting a proposal to perform a certain action, given certain preconditions
    case propose
    /// the sender wants the receiver to select target agents denoted by a given description and to send an embedded message to them
    case proxy
    /// the action of asking another agent whether or not a given proposition is true
    case queryIf
    /// the action of asking another agent for the object referred to by a referential expression
    case queryRef
    /// the action of refusing to perform a given action, and explaining the reason for the refusal
    case refuse
    /// the action of rejecting a proposal to perform some action during a negotiation
    case rejectProposal
    /// the sender requests the receiver to perform some action
    case request
    /// the sender wants the receiver to perform some action when some given proposition becomes true
    case requestWhen
    /// the sender wants the receiver to perform some action as soon as some proposition becomes true and thereafter each time the proposition becomes true again
    case requestWhenever
    /// the act of requesting a persistent intention to notify the sender of the value of a reference, and to notify again whenever the object identified by the reference changes
    case subscribe
}
