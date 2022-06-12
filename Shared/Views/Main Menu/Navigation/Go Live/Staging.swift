//
//  Lobby.swift
//  Nexus
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Staging: View {
    let user: AppUser
    
    @ObservedObject var session: Session
    @StateObject private var feed = FrameViewModel()
    @State private var channel: String = "/channel/1"
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Identity")) {
                        Identity(user: user)
                    }
                    Section(header: Text("Configure channel")) {
                        VStack {
                            TextField("/channel/1", text: $channel)
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
}

struct Lobby_Previews: PreviewProvider {
    static var previews: some View {
        Staging(user: AppUser(first: "Yura", last: "Filatov", email: "yura.fila@gmail.com", appleID: "UUID-1", rank: User.Rank(id: 1), createdAt: Date()), session: Session())
    }
}
