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
    let broker = Broker(ip: "c1a929ba1d4d441795f8467aa6277663.s1.eu.hivemq.cloud",
                      port: 8883,
                  username: "aibo-cora",
                  password: "sq!2L!EcFz9b!JA")
    lazy var components = CaptureComponents(captureSession: CameraManager.shared.session, delegate: FrameSupplier.shared)
    
    public override init() {
        super.init()
        
        jointSession = JointSession(apiKey: "C!9X5&/WPuU(6pp5",
                                    broker: broker,
                         captureComponents: components,
                                  delegate: nil,
                               loggingFlag: true)
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
            } catch JointSessionError.invalidAPIKey {
                
            } catch JointSessionError.clientConfiguration {
                
            }
            
            return (false, nil)
        }
        
        return try? await task.result.get()
    }
}
