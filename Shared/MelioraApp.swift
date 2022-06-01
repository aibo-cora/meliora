//
//  MelioraApp.swift
//  Shared
//
//  Created by Yura on 4/18/22.
//

import SwiftUI

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
