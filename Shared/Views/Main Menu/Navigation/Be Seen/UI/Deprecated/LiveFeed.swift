//
//  Streaming.swift
//  Nexus (iOS)
//
//  Created by Yura on 11/28/21.
//

import SwiftUI
import AVKit
import Joint

struct LiveFeed: View {
    @State var hasCameraPermission = false
    @State var hasMicrophonePermission = false
    
    @ObservedObject var session: Session
    @ObservedObject var user: User
    @ObservedObject var frameViewModel: FrameViewModel
    
    @ViewBuilder var body: some View {
        VStack {
//            if hasCameraPermission {
//                if hasMicrophonePermission {
//                    ZStack {
//                        CameraVideoFeed(frame: frameViewModel.frame)
//                            .onDisappear() { CameraManager.shared.stop() }
//                            .onAppear() { CameraManager.shared.start() }
//
//                        VStack {
//                            Spacer()
//
//                            // SessionControl(session: session, user: user)
//                        }
//                    }
//                } else {
//                    MicrophonePermissionView(permissionGranted: $hasMicrophonePermission)
//                }
//            } else {
//                CameraPermissionView(permissionGranted: $hasCameraPermission)
//            }
        }
    }
}

struct Streaming_Previews: PreviewProvider {
    static var previews: some View {
        LiveFeed(hasCameraPermission: true, hasMicrophonePermission: true, session: Session(), user: User(), frameViewModel: FrameViewModel())
    }
}
