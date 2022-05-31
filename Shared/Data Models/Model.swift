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
        self.streamers = [Streamer(user: User(first: "Yura", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(first: "Tom", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(first: "Kate", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(first: "Linda", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(first: "Alex", email: "yura.fila@gmail.com"), channel: ""),
                          Streamer(user: User(first: "Aurora", email: "yura.fila@gmail.com"), channel: "")]
        setupSubscription()
    }
    
    func select(streamer: Streamer) {
        selected = streamer
    }
    
    func setupSubscription() {
        
    }
}
