//
//  Server.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

class Server {
    let port: NWEndpoint.Port
    let listener: NWListener?
    let agent: Agent

    private var connectionsByID: [Int: ServerConnection] = [:]

    init(port: UInt16, agent: Agent) {
        self.port = NWEndpoint.Port(rawValue: port)!
        self.listener = try! NWListener(using: .tcp, on: self.port) //fazer tratamento nesse try
        self.agent = agent
    }

    func start() throws {
        print("Server starting...")
        self.listener?.stateUpdateHandler = self.stateDidChange(to:)
        self.listener?.newConnectionHandler = self.didAccept(nwConnection:)
        self.listener?.start(queue: .main)
    }

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

    private func didAccept(nwConnection: NWConnection) {
        let connection = ServerConnection(nwConnection: nwConnection, agent: self.agent)
        self.connectionsByID[connection.id] = connection
        connection.didStopCallback = { _ in
            self.connectionDidStop(connection)
        }
        connection.start()
        connection.send(data: "Welcome you are connection: \(connection.id)".data(using: .utf8)!)
        print("\n AQUI server didaccept \n")
        print("server did open connection \(connection.id)")
    }

    private func connectionDidStop(_ connection: ServerConnection) {
        self.connectionsByID.removeValue(forKey: connection.id)
        print("server did close connection \(connection.id)")
    }

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

