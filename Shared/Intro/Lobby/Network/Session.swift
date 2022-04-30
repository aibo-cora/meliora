//
//  LiveSession.swift
//  Nexus (iOS)
//
//  Created by Yura on 3/25/22.
//

import Foundation
import Joint
import Combine

public class Session: NSObject, ObservableObject {
    let broker = Broker(ip: "2457aa93d1444b8cb0dd5d5891a3c3d6.s1.eu.hivemq.cloud",
                      port: 8883,
                  username: "test.admin",
                  password: "P2ssword")
    lazy var components = CaptureComponents(captureSession: CameraManager.shared.session, delegate: FrameSupplier.shared)
    
    public override init() {
        super.init()
        
        jointSession = JointSession(apiKey: "C!9X5&/WPuU(6pp5",
                                    broker: broker,
                         captureComponents: components,
                                  delegate: nil,
                               loggingFlag: false)
        setupSubscription()
    }
    
    var jointSession: JointSession?
    
    @Published
    var sessionStatus: SessionStatus = .unknown
    @Published
    var streamers = [Streamer]()
    
    fileprivate func setupSubscription() {
        jointSession?.$sessionStatus
            .receive(on: RunLoop.main, options: nil)
            .assign(to: &$sessionStatus)
        
        jointSession?.$activeStreamers
            .receive(on: RunLoop.main, options: nil)
            .map { streamers in
                return Array(streamers)
            }
            .assign(to: &$streamers)
    }
    
    func establishConnection() async -> (didConnect: Bool, error: Error?)? {
        let task = Task { () -> (didConnect: Bool, error: Error?) in
            do {
                if try await jointSession?.configureClient() == true {
                    return (true, nil)
                }
            }
            
            return (false, nil)
        }
        
        return try? await task.result.get()
    }
}
