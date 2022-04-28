//
//  Lobby.swift
//  Nexus
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Lobby: View {
    @ObservedObject var user: User
    
    @State var channel: String = ""
    @State private var channels: [Channel] = [Channel(name: "")]
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Identity")) {
                    Identity(user: user)
                }
                Section(header: Text("Select channel")) {
                    VStack {
                        HStack {
                            TextField("/stream/video/welcome", text: $channel)
                                .focused($isFocused)
                        }
                        .padding()
                        
                        Button("Add") {
                            if channel.isEmpty {
                                isFocused = true
                            } else {
                                channels.removeAll()
                                channels.append(Channel(name: channel))
                                
                                isFocused = false
                            }
                        }
                    }
                }
                Section(header: Text("Channels")) {
                    List(channels) { channel in
                        if !channel.name.isEmpty {
                            NavigationLink(destination: {
                                Network(channel: channel.name, user: user)
                            }, label: {
                                Text(channel.name)
                                    .padding()
                            })
                        }
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

struct Lobby_Previews: PreviewProvider {
    static var previews: some View {
        Lobby(user: User(name: "Yura", email: "yura.fila@gmail.com"), channel: "")
    }
}
