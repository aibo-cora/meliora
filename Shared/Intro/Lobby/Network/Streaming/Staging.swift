//
//  Lobby.swift
//  Nexus
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Staging: View {
    var user: User
    var session: Session
    
    @StateObject private var feed = FrameViewModel()
    @State private var channel: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Identity")) {
                    Identity(user: user)
                }
                Section(header: Text("Configure channel")) {
                    VStack {
                        TextField("/stream/video/welcome", text: $channel)
                            .padding()
                    }
                }
            }
            .navigationTitle("Stream Settings")
            .navigationBarTitleDisplayMode(.inline)
            
            NavigationLink {
                LiveFeed(session: session, streamer: Streamer(user: user, channel: channel), image: feed.frame)
                    .ignoresSafeArea()
            } label: {
                Text("Start")
            }
            .disabled(channel.isEmpty)
            .padding(.bottom)
        }
    }
}

struct Lobby_Previews: PreviewProvider {
    static var previews: some View {
        Staging(user: User(name: "Yura", email: "yura.fila@gmail.com"), session: Session())
    }
}
