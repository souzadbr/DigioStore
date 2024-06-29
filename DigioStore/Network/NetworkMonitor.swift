//
//  NetworkMonitor.swift
//  DigioStore
//
//  Created by Debora Rodrigues  on 29/06/24.
//

import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global()
    
    public private(set) var isConnected: Bool = false {
        didSet {
            if isConnected != oldValue {
                NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
            }
        }
    }
    
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
}
