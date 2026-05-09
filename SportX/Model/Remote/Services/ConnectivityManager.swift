//
//  ConnectivityManager.swift
//  SportX
//
//  Created by Zeiad Mohammed on 11/05/2026.
//

import Foundation
import Network

final class ConnectivityManager {

    static let shared = ConnectivityManager()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ConnectivityMonitor")
    private(set) var isConnected: Bool = true

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
        monitor.start(queue: queue)
    }
}
