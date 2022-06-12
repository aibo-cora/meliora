//
//  Network.swift
//  Nexus
//
//  Created by Yura on 11/14/21.
//

import SwiftUI

struct WatchVideos: View {
    @ObservedObject var session: Session
    @ObservedObject var user: AppUser
    
    var body: some View {
        NavigationView {
            VStack {
                StreamerList(streamers: session.streamers, session: session)
                
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
            WatchVideos(session: Session(), user: AppUser())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
