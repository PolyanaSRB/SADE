//
//  Client.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

/// Client class represents an endpoint to connect to an address (host and port) to send messages.
class Client {
    /// connection to send messages
    let connection: ClientConnection
    /// host address
    let host: NWEndpoint.Host
    /// port address
    let port: NWEndpoint.Port

    /// - parameter host: host address
    /// - parameter port: port address
    init(host: String, port: UInt16) {
        self.host = NWEndpoint.Host(host)
        self.port = NWEndpoint.Port(rawValue: port)!
        let nwConnection = NWConnection(host: self.host, port: self.port, using: .tcp)
        connection = ClientConnection(nwConnection: nwConnection)
    }

    /// Starts the connection.
    func start() {
        print("Client started \(host) \(port)")
        connection.didStopCallback = didStopCallback(error:)
        connection.start()
    }

    /// Stops the connection.
    func stop() {
        connection.stop()
    }

    /// Sends a message as a Data object through a ClientConnection.
    func send(data: Data) {
        connection.send(data: data)
    }

    /// Detects a failure.
    func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }
}
