//
//  ContentView.swift
//  Shared
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Intro: View {
    private var user = User()
    @State var authenticated = false
    
    var body: some View {
        if authenticated {
            Network(channel: "", user: user)
        } else {
            SignIn(user: user, authenticated: $authenticated)
        }
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}
