//
//  Network.swift
//  Nexus
//
//  Created by Yura on 11/14/21.
//

import SwiftUI
import Joint

struct WatchVideos: View {
    @ObservedObject var session: Session
    @ObservedObject var user: AppUser
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    ForEach(Array(session.streamers.enumerated()), id: \.element) { index, streamer in
                        Watching(streamer: streamer, session: session)
                            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            
                    }
                }
            }
            .onReceive(session.$streamers, perform: { streamers in
                streamers.forEach { streamer in
                    
                }
            })
        }
        .ignoresSafeArea()
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
