//
//  ContentView.swift
//  Shared
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Intro: View {
    @StateObject var user = User()
    
    var body: some View {
        if user.email.isEmpty {
            SignIn(user: user)
        } else {
            Network()
                .environmentObject(user)
        }
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}
