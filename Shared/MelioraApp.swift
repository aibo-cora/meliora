//
//  MelioraApp.swift
//  Shared
//
//  Created by Yura on 4/18/22.
//

import SwiftUI
import Joint

@main
struct MelioraApp: App {
    @StateObject var network = NetworkCom()
    
    var body: some Scene {
        WindowGroup {
            Intro()
                .environmentObject(network)
        }
    }
}
