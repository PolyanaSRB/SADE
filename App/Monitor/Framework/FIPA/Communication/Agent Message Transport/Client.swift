//
//  Client.swift
//  Monitor
//
//  Created by user174461 on 11/30/21.
//  Copyright © 2021 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

class Client {

    init() {
        let nwConnection = NWConnection(host: "69.160.250.184", port: 8080, using: .tcp)
        self.connection = Connection(nwConnection: nwConnection)
    }

    let connection: Connection

    func start() {
        self.connection.didStopCallback = self.didStopCallback(error:)
        self.connection.start()
    }

    func didStopCallback(error: Error?) {
        if error == nil {
            exit(EXIT_SUCCESS)
        } else {
            exit(EXIT_FAILURE)
        }
    }

    static func run() {
        let client = Client()
        client.start()
        print("client ok")
        dispatchMain()
    }
}
