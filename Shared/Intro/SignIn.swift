//
//  SignIn.swift
//  Nexus
//
//  Created by Yura on 11/13/21.
//

import SwiftUI
import AuthenticationServices
import Joint

struct SignIn: View {
    var user: User
    @Binding var authenticated: Bool
    
    var body: some View {
        VStack {
            Text("Please sign in with Apple to identify yourself on the network")
                .font(.footnote)
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in request.requestedScopes = [.fullName, .email] },
                onCompletion: { result in
                    switch result {
                    case .success (let auth):
                        guard let credentials = auth.credential as? ASAuthorizationAppleIDCredential else { return }
                        
                        let name = credentials.fullName?.givenName ?? "Unknown"
                        let email = credentials.email ?? "\(UUID().uuidString)"
                        
                        user.update(name: name, email: email)
                        SaveCredentials()
                        
                        authenticated.toggle()
                    case .failure (let error):
                        
                        print("Authorization failed: " + error.localizedDescription)
                    }
            })
            .frame(width: 200, height: 30)
            .font(.title)
        }
    }
    
    private func SaveCredentials() {
        print(user.name, user.email)
    }
}

#if DEBUG
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(user: User(), authenticated: .constant(false))
    }
}
#endif
