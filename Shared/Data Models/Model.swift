//
//  Model.swift
//  Nexus (iOS)
//
//  Created by Yura on 4/1/22.
//

import Foundation
import Joint

class Model: ObservableObject {
    @Published
    var streamers = [Streamer]() {
        didSet {
            print("Model changed, count=\(streamers.count)")
        }
    }
    
    @Published
    var selected: Streamer? = nil

    init() {
        self.streamers = [Streamer(user: User(name: "Yura", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(name: "Tom", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(name: "Kate", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(name: "Linda", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(name: "Alex", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(name: "Aurora", email: "yura.fila@gmail.com"), channel: "")]
        setupSubscription()
    }
    
    func select(streamer: Streamer) {
        selected = streamer
    }
    
    func setupSubscription() {
        
    }
}
