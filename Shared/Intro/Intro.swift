//
//  ContentView.swift
//  Shared
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Intro: View {
    let udKey = "Meliora.User.Auth"
    
    var user: User {
        if let data = UserDefaults.standard.data(forKey: udKey) {
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                return user
            }
        }
        return User(name: "Unknown", email: "Unknown")
    }
    @State var authenticated = false
    
    var body: some View {
        if false {
            SignIn(user: user, authenticated: $authenticated)
        } else {
            Network(channel: "", user: User(name: "John Doe", email: "john.doe@gmail.com"))
        }
    }
    
    var firstTimeUser: Bool {
        user.name == "Unknown" && user.email == "Unknown"
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}
