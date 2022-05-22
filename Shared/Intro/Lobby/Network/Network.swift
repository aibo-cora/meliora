//
//  Network.swift
//  Nexus
//
//  Created by Yura on 11/14/21.
//

import SwiftUI
import Joint

struct Network: View {
    let channel: String
    let user: User
    
    @StateObject var session = Session()
    
    var body: some View {
        NavigationView {
            VStack {
                StreamerList(streamers: session.streamers, session: session)
                    .navigationTitle("Network")
                    .toolbar {
                        ToolbarItem() {
                            NavigationLink(destination: Staging(user: user, session: session)) {
                                HStack {
                                    Image(systemName: "video.fill")
                                }
                            }
                        }
                    }
                    .task {
                        let _ = await session.establishConnection()
                    }
                
                Spacer()
                
    //            if let streamer = session.model.selected {
    //                VStack(alignment: .center) {
    //                    Text(streamer.email)
    //                    Image(systemName: "network")
    //                        .resizable()
    //                        .frame(width: 100, height: 100)
    //                    Button {
    //
    //                    } label: {
    //                        Text("Join Stream")
    //                    }
    //                }
    //                .padding()
    //            }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct Network_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Network(channel: "/video", user: User())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
