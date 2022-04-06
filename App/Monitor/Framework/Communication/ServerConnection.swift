//
//  ServerConnection.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

/// ServerConnection class represents a network connection to a Server into an address.
class ServerConnection {
    /// the TCP maximum package size, from 64000 to 65536
    let MTU = 65536

    /// iterable integer to associate an ID to the connection
    private static var nextID: Int = 0
    /// network connection
    let  connection: NWConnection
    /// connection id
    let id: Int
    /// receiver agent through this connection
    var agent: Agent

    /// - parameter nwConnection: network connection
    /// - parameter agent: receiver agent through this connection
    init(nwConnection: NWConnection, agent: Agent) {
        connection = nwConnection
        id = ServerConnection.nextID
        ServerConnection.nextID += 1
        self.agent = agent
    }

    /// error control variable
    var didStopCallback: ((Error?) -> Void)? = nil

    /// Starts the connection.
    func start() {
        print("connection \(id) will start")
        connection.stateUpdateHandler = self.stateDidChange(to:)
        setupReceive()
        connection.start(queue: .main)
    }

    /// Perceives a change into the connection state.
    /// - parameter state: new state after the change
    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .waiting(let error):
            connectionDidFail(error: error)
        case .ready:
            print("connection \(id) ready")
        case .failed(let error):
            connectionDidFail(error: error)
        default:
            break
        }
    }

    /// Message receiver through the connection and translator from Data to ACLMessage.
    ///
    /// In this function, you can decide what to do when an agent receives a message. By default, it calls the BDI reasoning cycle (function runBDICycle).
    private func setupReceive() {
        connection.receive(minimumIncompleteLength: 1, maximumLength: MTU) { (data, _, isComplete, error) in
            if let data = data, !data.isEmpty {
                let acl = try! NSKeyedUnarchiver.unarchivedObject(ofClass: ACLMessage.self, from: data)
                let content = acl!.content
                self.agent.runBDICycle()
                print("connection \(self.id) did receive, data: \(data as NSData) string: \(content ?? "-")")
                //self.send(data: data)
            }
            if isComplete {
                self.connectionDidEnd()
            } else if let error = error {
                self.connectionDidFail(error: error)
            } else {
                self.setupReceive()
            }
        }
    }

    /// Sends a message as a Data object through network connection.
    /// - parameter data: message to be sent as Data object
    func send(data: Data) {
        self.connection.send(content: data, completion: .contentProcessed( { error in
            if let error = error {
                self.connectionDidFail(error: error)
                return
            }
            print("connection \(self.id) did send, data: \(data as NSData)")
        }))
    }

    /// Stops the connection.
    func stop() {
        print("connection \(id) will stop")
    }

    /// Stops the connection due to an error
    /// - parameter error: error that caused the connection failure
    private func connectionDidFail(error: Error) {
        print("connection \(id) did fail, error: \(error)")
        stop(error: error)
    }

    /// Stops the connection because it was ended,
    private func connectionDidEnd() {
        print("connection \(id) did end")
        stop(error: nil)
    }

    /// Stops the connection.
    /// - parameter error: error that caused a connection failure
    private func stop(error: Error?) {
        connection.stateUpdateHandler = nil
        connection.cancel()
        if let didStopCallback = didStopCallback {
            self.didStopCallback = nil
            didStopCallback(error)
        }
    }
}
