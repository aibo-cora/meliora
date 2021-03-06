//
//  LiveSession.swift
//  Nexus (iOS)
//
//  Created by Yura on 3/25/22.
//

import Foundation
import Joint
import AVFoundation
import Combine

public class Session: NSObject, ObservableObject {
    let broker = Broker(ip: "ec4735464b1046269ee2cea58d53b355.s1.eu.hivemq.cloud",
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
    
    @Published var sessionStatus: SessionStatus = .unknown
    @Published var streamers = [Streamer]()
    
    var subscriptions = [AnyCancellable]()
    
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
    
    func establishConnection() async throws -> (didConnect: Bool, error: String?) {
        let task = Task { () -> (didConnect: Bool, error: String?) in
            do {
                if try await jointSession?.configureClient() == true {
                    return (true, nil)
                }
            } catch JointSessionError.invalidAPIKey {
                return (false, "Invalid API key.")
            } catch JointSessionError.clientConfiguration {
                return (false, "Invalid client configuration.")
            } catch {
                
            }
            
            return (false, nil)
        }
        
        return try await task.result.get()
    }
}
