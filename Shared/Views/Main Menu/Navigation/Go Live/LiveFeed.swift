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
    
    var image: CGImage?
    private let label = Text("Camera feed")
    
    @ViewBuilder var body: some View {
        VStack {
            if hasCameraPermission {
                if hasMicrophonePermission {
                    if let feed = image {
                        ZStack {
                            GeometryReader { geometry in
                                Image(feed, scale: 1.0, orientation: .leftMirrored, label: label)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width,
                                           height: geometry.size.height,
                                           alignment: .center)
                                    .clipped()
                            }
                            .onDisappear() { CameraManager.shared.stop() }
                            .onAppear() { CameraManager.shared.start() }
                            
                            VStack {
                                Spacer()
                                
                                StreamingControl(session: session, user: user)
                            }
                        }
                    } else {
                        Color.black
                    }
                } else {
                    MicrophonePermission(permissionGranted: $hasMicrophonePermission)
                }
            } else {
                CameraPermission(permissionGranted: $hasCameraPermission)
            }
        }
    }
}

struct Streaming_Previews: PreviewProvider {
    static var previews: some View {
        LiveFeed(hasCameraPermission: true, hasMicrophonePermission: true, session: Session(), user: User())
    }
}
