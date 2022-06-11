//
//  ContentView.swift
//  Shared
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import Joint

struct Intro: View {
    @StateObject var user = AppUser()
    
    var body: some View {
        if user.email.isEmpty {
            SignIn(user: user)
        } else {
            Onboarding()
                .environmentObject(user)
        }
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
        Intro()
    }
}
