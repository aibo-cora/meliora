//
//  LiveSessionControl.swift
//  Meliora
//
//  Created by Yura on 6/17/22.
//

import SwiftUI
import Joint

struct LiveSessionControl: View {
    @State private var streaming = false
    
    @ObservedObject var session: Session
    @ObservedObject var user: User
    
    @ViewBuilder var body: some View {
        switch session.sessionStatus {
        case .unknown:
            DisplayErrorMessage(message: "Critical error: Session status unknown.")
        case .connecting:
            DisplayErrorMessage(message: "Starting up session, please wait...")
        case .connected:
            Button(action: {
                print(streaming ? "Stopped streaming" : "Started streaming")
                
                let streamer = Streamer(user: user, channel: user.id)
                streaming ? session.jointSession?.stopSession(streamer: streamer) : session.jointSession?.startSession(streamer: streamer)
                streaming.toggle()
            }) {
                SessionControlLabel(condition: streaming, label: "Live")
            }
        default:
            DisplayErrorMessage(message: "Session failed, please restart...")
        }
    }
    
    struct DisplayErrorMessage: View {
        @State private var blink = false
        
        let message: String
        
        var body: some View {
            Text(message)
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

struct LiveSessionControl_Previews: PreviewProvider {
    static var previews: some View {
        LiveSessionControl(session: Session(), user: User())
    }
}
