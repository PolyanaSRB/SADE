//
//  Client.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

class Client {
    let connection: ClientConnection
    let host: NWEndpoint.Host
    let port: NWEndpoint.Port

    init(host: String, port: UInt16) {
        self.host = NWEndpoint.Host(host)
        self.port = NWEndpoint.Port(rawValue: port)!
        let nwConnection = NWConnection(host: self.host, port: self.port, using: .tcp)
        connection = ClientConnection(nwConnection: nwConnection)
    }

    func start() {
        print("\n AQUI client start \n")
        print("Client started \(host) \(port)")
        connection.didStopCallback = didStopCallback(error:)
        connection.start()
    }

    func stop() {
        connection.stop()
    }

    func send(data: Data) {
        connection.send(data: data)
    }

    func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }
}
