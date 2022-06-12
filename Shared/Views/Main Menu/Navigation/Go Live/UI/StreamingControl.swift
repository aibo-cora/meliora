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
    @State private var streaming = false
    
    @ObservedObject var session: Session
    @ObservedObject var user: User
    
    @ViewBuilder var body: some View {
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
                print(streaming ? "Stopped streaming" : "Started streaming")
                
                let streamer = Streamer(user: user, channel: user.id)
                streaming ? session.jointSession?.stopSession(streamer: streamer) : session.jointSession?.startSession(streamer: streamer)
                streaming.toggle()
            }) {
                if self.streaming {
                    BlinkingLiveButton()
                } else {
                    StartLiveStreamButton()
                }
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
