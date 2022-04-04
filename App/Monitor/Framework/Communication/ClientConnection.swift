//
//  ClientConnection.swift
//  Monitor
//
//  Created by user174461 on 2/8/22.
//  Copyright © 2022 Polyana Barboza. All rights reserved.
//

import Foundation
import Network

/// ClientConnection class represents a network connection to send messages to an address.
class ClientConnection {

    /// network connection
    let  nwConnection: NWConnection
    /// manager of the messages queue
    let queue = DispatchQueue(label: "Client connection Q")

    /// - parameter nwConnection: network connection
    init(nwConnection: NWConnection) {
        self.nwConnection = nwConnection
    }

    /// error control variable
    var didStopCallback: ((Error?) -> Void)? = nil

    /// Starts the connection.
    func start() {
        print("connection will start")
        nwConnection.stateUpdateHandler = stateDidChange(to:)
        setupReceive()
        nwConnection.start(queue: queue)
    }

    /// Perceives a change into the connection state.
    /// - parameter state: new state after the change
    private func stateDidChange(to state: NWConnection.State) {
        switch state {
        case .waiting(let error):
            connectionDidFail(error: error)
        case .ready:
            print("Client connection ready")
        case .failed(let error):
            connectionDidFail(error: error)
        default:
            break
        }
    }
    
    /// Message receiver through the connection.
    ///
    /// In general, the Client just receive a connection confirmation from the Server
    private func setupReceive() {
        nwConnection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { (data, _, isComplete, error) in
            if let data = data, !data.isEmpty {
                let message = String(data: data, encoding: .utf8)
                print("connection did receive, data: \(data as NSData) string: \(message ?? "-" )")
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
    func  send(data: Data) {
        nwConnection.send(content: data, completion: .contentProcessed( { error in
            if let error = error {
                self.connectionDidFail(error: error)
                return
            }
            print("connection did send, data: \(data as NSData)")
        }))
    }

    /// Stops the connection.
    func stop() {
        print("connection will stop")
        stop(error: nil)
    }

    /// Stops the connection due to an error
    /// - parameter error: error that caused the connection failure
    private func connectionDidFail(error: Error) {
        print("connection did fail, error: \(error)")
        self.stop(error: error)
    }

    /// Stops the connection because it was ended,
    private func connectionDidEnd() {
        print("\n AQUI client connection connectionend \n")
        print("connection did end")
        self.stop(error: nil)
    }

    /// Stops the connection.
    /// - parameter error: error that caused a connection failure
    private func stop(error: Error?) {
        self.nwConnection.stateUpdateHandler = nil
        self.nwConnection.cancel()
        if let didStopCallback = self.didStopCallback {
            self.didStopCallback = nil
            didStopCallback(error)
        }
    }
}
