//
//  StreamButton.swift
//  Nexus (iOS)
//
//  Created by Yura on 3/21/22.
//

import SwiftUI
import Joint

struct SessionControl: View {
    @Binding var mode: BeSeen.SessionModes.RawValue
    
    @ObservedObject var session: Session
    @ObservedObject var user: User
    @ObservedObject var cameraManager: CameraManager
    
    @ViewBuilder var body: some View {
        switch mode {
        case BeSeen.SessionModes.live.rawValue:
            LiveSessionControl(session: session, user: user)
                .onDisappear {
                    // stop live session
                }
        default:
            RecordingSessionControl()
                .onDisappear {
                    // stop recording
                }
        }
        
    }
}

struct StreamButton_Previews: PreviewProvider {
    static var previews: some View {
        SessionControl(mode: .constant(0), session: Session(), user: User(), cameraManager: CameraManager.shared)
    }
}
