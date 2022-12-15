//
//  NetworkObserver.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var isConnected: Observable<Bool?> = Observable(nil)

    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }

    func startMonitoring() {
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected.value = path.status == .satisfied
        }
    }

    func stopMonitoring() {
        self.monitor.cancel()
    }
}
