//
//  Server.swift
//  Monitor
//
//  Created by user174461 on 11/30/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

class Server {

    init() {
        self.listener = try! NWListener(using: .tcp, on: 8080)
        self.timer = DispatchSource.makeTimerSource(queue: .main)
    }

    let listener: NWListener
    let timer: DispatchSourceTimer

    func start() throws {
        print("server will start")
        self.listener.stateUpdateHandler = self.stateDidChange(to:)
        self.listener.newConnectionHandler = self.didAccept(nwConnection:)
        self.listener.start(queue: .main)
    
        self.timer.setEventHandler(handler: self.heartbeat)
        self.timer.schedule(deadline: .now() + 5.0, repeating: 5.0)
        self.timer.activate()
    }

    func stateDidChange(to newState: NWListener.State) {
        switch newState {
        case .setup:
            break
        case .waiting:
            break
        case .ready:
            break
        case .failed(let error):
            print("server did fail, error: \(error)")
            self.stop()
        case .cancelled:
            break
        default:
            break
        }
    }

    private var connectionsByID: [Int: Connection] = [:]

    private func didAccept(nwConnection: NWConnection) {
        let connection = Connection(nwConnection: nwConnection)
        self.connectionsByID[connection.id] = connection
        connection.didStopCallback = { _ in
            self.connectionDidStop(connection)
        }
        connection.start()
        print("server did open connection \(connection.id)")
    }

    private func connectionDidStop(_ connection: Connection) {
        self.connectionsByID.removeValue(forKey: connection.id)
        print("server did close connection \(connection.id)")
    }

    private func stop() {
        self.listener.stateUpdateHandler = nil
        self.listener.newConnectionHandler = nil
        self.listener.cancel()
        for connection in self.connectionsByID.values {
            connection.didStopCallback = nil
            connection.stop()
        }
        self.connectionsByID.removeAll()
        self.timer.cancel()
    }

    private func heartbeat() {
        let timestamp = Date()
        print("server heartbeat, timestamp: \(timestamp)")
        for connection in self.connectionsByID.values {
            let data = "heartbeat, connection: \(connection.id), timestamp: \(timestamp)\r\n"
            connection.send(data: Data(data.utf8))
        }
    }

    static func run() {
        let listener = Server()
        try! listener.start()
        print("server ok")
        dispatchMain()
    }
}
