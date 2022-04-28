//
//  StreamButton.swift
//  Nexus (iOS)
//
//  Created by Yura on 3/21/22.
//

import SwiftUI
import Joint

struct StreamingControl: View {
    @Binding
    var status: SessionStatus
    
    @State
    private var blink = false
    
    let session: JointSession?
    let streamer: Streamer
    
    var body: some View {
        if status == .unknown {
            
        }
        if status == .connecting {
            Text("Starting up session, please wait...")
                .foregroundColor(.white)
                .padding(.bottom, 50)
                .opacity(blink ? 0 : 1)
                .onAppear() {
                    withAnimation(Animation
                        .linear(duration: 2)
                        .repeatForever()) { blink.toggle() }
                }
        }
        if status == .connected {
            Button(action: {
                print(CameraManager.shared.streaming ? "Stopped streaming" : "Started streaming")
                CameraManager.shared.streaming ? session?.stopSession() : session?.startSession(streamer: streamer)
                CameraManager.shared.streaming.toggle()
            }) {
                Image(systemName: CameraManager.shared.streaming ? "stop.fill" : "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                    .clipped()
                    .foregroundColor(.red)
                    .padding(.bottom, 40)
            }
        }
        if status == .failed {
            Text("Session failed, please restart...")
                .foregroundColor(.white)
                .padding(.bottom, 50)
                .opacity(blink ? 0 : 1)
                .onAppear() {
                    withAnimation(Animation
                        .easeInOut(duration: 2)
                        .repeatForever()) { blink.toggle() }
                }
        }
    }
}

struct StreamButton_Previews: PreviewProvider {
    static var previews: some View {
        StreamingControl(status: .constant(.unknown), session: nil, streamer: Streamer(user: User(), channel: ""))
    }
}
