//
//  Lobby.swift
//  Nexus
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Staging: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var session: Session
    
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
                LiveFeed(session: session, user: user, image: feed.frame)
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
        Staging()
    }
}
