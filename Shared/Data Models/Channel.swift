//
//  Channel.swift
//  Nexus
//
//  Created by Yura on 11/14/21.
//

import Foundation

class Channel: ObservableObject, Identifiable {
    let id = UUID()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
