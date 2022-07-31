//
//  MainMenu.swift
//  Meliora
//
//  Created by Yura on 6/11/22.
//

import SwiftUI

struct MainMenu: View {
    @StateObject var session = Session()
    @State private var ready = false
    
    let user: AppUser
    
    @ViewBuilder var body: some View {
        if !ready {
            ProgressView("Connecting...")
                .task {
                    do {
                        if try await session.establishConnection().didConnect {
                            self.ready = true
                        }
                    } catch {
                        
                    }
                }
        } else {
            TabView {
                WatchVideos(session: session, user: user)
                    .tabItem {
                        VStack {
                            Image(systemName: "tv.fill")
                            Text("Watch")
                        }
                    }
                Staging(user: user, session: session)
                    .tabItem {
                        VStack {
                            Image(systemName: "livephoto.play")
                            Text("Be Seen")
                        }
                    }
                Social()
                    .tabItem {
                        VStack {
                            Image(systemName: "bubble.left.fill")
                            Text("Comm")
                        }
                    }
                ContentManagement()
                    .tabItem {
                        VStack {
                            Image(systemName: "command")
                            Text("For You")
                        }
                    }
                AppSettings()
                    .tabItem {
                        VStack {
                            Image(systemName: "gear")
                            Text("Settings")
                        }
                    }
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainMenu(user: AppUser())
                .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))
                .previewDisplayName("iPhone 13 Pro Max")

            MainMenu(user: AppUser())
                .previewDevice(PreviewDevice(rawValue: "iPhone X"))
                .previewDisplayName("iPhone X")
        }
    }
}
