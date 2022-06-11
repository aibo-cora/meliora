//
//  MainMenu.swift
//  Meliora
//
//  Created by Yura on 6/11/22.
//

import SwiftUI

struct MainMenu: View {
    var body: some View {
        TabView {
            WatchVideos()
                .tabItem {
                    VStack {
                        Image(systemName: "play.tv.fill")
                        Text("Watch")
                    }
                }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
