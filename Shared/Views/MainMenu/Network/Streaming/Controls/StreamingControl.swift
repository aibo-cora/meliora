//
//  StreamButton.swift
//  Nexus (iOS)
//
//  Created by Yura on 3/21/22.
//

import SwiftUI
import Joint

struct StreamingControl: View {
    @State private var blink = false
    
    @ObservedObject var session: Session
    @ObservedObject var user: User
    
    var body: some View {
        if session.sessionStatus == .unknown {
            
        }
        if session.sessionStatus == .connecting {
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
        if session.sessionStatus == .connected {
            Button(action: {
                print(CameraManager.shared.streaming ? "Stopped streaming" : "Started streaming")
                
                let streamer = Streamer(user: user, channel: user.id)
                CameraManager.shared.streaming ? session.jointSession?.stopSession(streamer: streamer) : session.jointSession?.startSession(streamer: streamer)
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
        if session.sessionStatus == .failed {
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
        StreamingControl(session: Session(), user: User())
    }
}
