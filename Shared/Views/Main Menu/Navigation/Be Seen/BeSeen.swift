//
//  BeSeen.swift
//  Meliora
//
//  Created by Yura on 6/17/22.
//

import SwiftUI

struct BeSeen: View {
    public enum SessionModes: Int {
        case recording, live
    }
    
    @State private var selection = SessionModes.recording.rawValue
    @StateObject private var frameViewModel = FrameViewModel()
    
    let user: AppUser
    
    @ObservedObject var session: Session
    
    @ViewBuilder var body: some View {
        ZStack {
            CameraVideoFeed(frame: frameViewModel.frame)
                .onAppear() { CameraManager.shared.start() }
                .onDisappear() { CameraManager.shared.stop() }
                .ignoresSafeArea()
            
            VStack {
                Picker("Record a video to share or start a live stream", selection: $selection) {
                    Text("Recording")
                        .tag(0)
                    Text("Live Stream")
                        .tag(1)
                }
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
                
                SessionControl(mode: $selection, session: session, user: user, cameraManager: CameraManager.shared)
            }
        }
    }
}

struct BeSeen_Previews: PreviewProvider {
    static var previews: some View {
        BeSeen(user: AppUser(), session: Session())
    }
}
