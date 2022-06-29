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
    
    @State private var selection = SessionModes.live.rawValue
    @StateObject private var frameViewModel = FrameViewModel()
    @StateObject private var cameraManager = CameraManager.shared
    
    let user: AppUser
    
    @ObservedObject var session: Session
    
    @ViewBuilder var body: some View {
        switch cameraManager.status {
        case .configured:
            ZStack {
                CameraVideoFeed(frame: frameViewModel.frame)
                    .onAppear() { CameraManager.shared.start() }
                    .onDisappear() { CameraManager.shared.stop() }
                    .ignoresSafeArea()
                
                VStack {
//                    Picker("Record a video to share or start a live stream", selection: $selection) {
//                        Text("Recording")
//                            .tag(0)
//                        Text("Live Stream")
//                            .tag(1)
//                    }
//                    .pickerStyle(.segmented)
//                    .padding()
                    
                    Spacer()
                    
                    SessionControl(mode: $selection, session: session, user: user, cameraManager: CameraManager.shared)
                }
            }
        case .unauthorized:
            VStack {
                Text("Microphone or Camera permission was denied or restricted previously. Full access is required for the best possible experience during a stream. Change your Settings.")
                    .padding()
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!,
                                                 options: [:],
                                       completionHandler: nil)
                } label: {
                    Text("Open Settings")
                }
            }
        default:
            ProgressView()
        }
        
    }
}

struct BeSeen_Previews: PreviewProvider {
    static var previews: some View {
        BeSeen(user: AppUser(), session: Session())
    }
}
