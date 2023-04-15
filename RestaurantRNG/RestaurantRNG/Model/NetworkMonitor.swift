//
//  NetworkMonitor.swift
//  RestaurantRNG
//
//  Created by Eric Crawford on 4/15/23.
//

import Network

// create singleton NetworkMonitor that can be accessed anywhere in code
class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    private init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
