//
//  Server.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

/// Server class allocates each Agent in a host (localhost, by default) and a port to receive messages
///
/// The Server behaves as a listener, which is represented by NWListener class, an Apple class offered by Network framework to create an object to listen for incoming network connections and that is ready to receive messages at any time.
class Server {
    /// port address
    let port: NWEndpoint.Port
    /// listener ready to listen for incoming network connections
    let listener: NWListener?
    /// software agent that will receive messages trough the listener into the address
    let agent: Agent

    /// dictionary where the key is an integer id and the value is the stablished connection
    private var connectionsByID: [Int: ServerConnection] = [:]

    /// - parameter port: port address
    /// - parameter agent: software agent that will receive messages trough the listener into the address
    init(port: UInt16, agent: Agent) {
        self.port = NWEndpoint.Port(rawValue: port)!
        self.listener = try! NWListener(using: .tcp, on: self.port) //fazer tratamento nesse try
        self.agent = agent
    }

    /// Starts the listener.
    func start() throws {
        print("Server starting...")
        self.listener?.stateUpdateHandler = self.stateDidChange(to:)
        self.listener?.newConnectionHandler = self.didAccept(nwConnection:)
        self.listener?.start(queue: .main)
    }

    /// Perceives a change into the listener state.
    /// - parameter newState: new state after the change
    func stateDidChange(to newState: NWListener.State) {
        switch newState {
        case .ready:
          print("Server ready.")
        case .failed(let error):
            print("Server failure, error: \(error.localizedDescription)")
            exit(EXIT_FAILURE)
        default:
            break
        }
    }

    /// Accepts new connections turning it into ServerConnection and inserting into connectionsByID array.
    /// - parameter nwConnection: a new network connection
    private func didAccept(nwConnection: NWConnection) {
        let connection = ServerConnection(nwConnection: nwConnection, agent: self.agent)
        self.connectionsByID[connection.id] = connection
        connection.didStopCallback = { _ in
            self.connectionDidStop(connection)
        }
        connection.start()
        connection.send(data: "Welcome you are connection: \(connection.id)".data(using: .utf8)!)
        print("server did open connection \(connection.id)")
    }

    /// Perceives that a connection stopped and removes it from the connectionsByID array.
    /// - parameter connection: the connection that must be removed
    private func connectionDidStop(_ connection: ServerConnection) {
        self.connectionsByID.removeValue(forKey: connection.id)
        print("server did close connection \(connection.id)")
    }

    /// Stops the listener;
    private func stop() {
        self.listener?.stateUpdateHandler = nil
        self.listener?.newConnectionHandler = nil
        self.listener?.cancel()
        for connection in self.connectionsByID.values {
            connection.didStopCallback = nil
            connection.stop()
        }
        self.connectionsByID.removeAll()
    }
}

