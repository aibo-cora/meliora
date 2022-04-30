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
    let broker = Broker(ip: <#ServerIP#>,
                      port: <#Port#>,
                  username: <#username#>,
                  password: <#password#>,
                    apiKey: "C!9X5&/WPuU(6pp5")
    lazy var components = CaptureComponents(captureSession: CameraManager.shared.session, delegate: FrameSupplier.shared)
    
    public override init() {
        super.init()
        
        jointSession = JointSession(broker: broker,
                         captureComponents: components,
                                  delegate: nil,
                               loggingFlag: false)
        setupSubscription()
    }
    
    var jointSession: JointSession?
    
    private var statusSub: AnyCancellable?
    private var streamerSub: AnyCancellable?
    
    @Published
    var sessionStatus: SessionStatus = .unknown
    @Published
    var streamers = [Streamer]()
    
    fileprivate func setupSubscription() {
        jointSession?.$sessionStatus
            .receive(on: RunLoop.main, options: nil)
            .assign(to: &$sessionStatus)
        statusSub = jointSession?.$sessionStatus
            .sink(receiveValue: { status in
                print(status)
            })
        
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
    
    func start(watching streamer: Streamer) {
        
    }
    
    func stop(watching streamer: Streamer) {
        
    }
}
