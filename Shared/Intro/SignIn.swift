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
    let udKey = "Meliora.User.Auth"
    var user: User
    
    @Binding var authenticated: Bool
    
    var body: some View {
        VStack {
            Text("Please sign in with Apple to identify yourself on the network")
                .font(.footnote)
            SignInWithAppleButton(.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success (let auth):
                    guard let credentials = auth.credential as? ASAuthorizationAppleIDCredential else { return }
                    
                    if let name = credentials.fullName?.formatted(), let email = credentials.email {
                        user.update(name: name, email: email)
                        SaveCredentials(identifier: credentials.user)
                    } else {
                        NSLog("The user has authorized this app before and is stored.")
                    }
                    
                    authenticated = true
                case .failure (let error):
                    print("Authorization failed: " + error.localizedDescription)
                }
            }
            .frame(width: 200, height: 30)
            .font(.title)
        }
    }
    
    /// This should be saved in the keychain or external database to survive app deletion.
    /// - Parameter identifier: Unique Apple auth ID
    private func SaveCredentials(identifier: String) {
        print(user.name, user.email, identifier)
        
        let data = try? JSONEncoder().encode(user)
        UserDefaults.standard.set(data, forKey: udKey)
    }
}

#if DEBUG
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(user: User(), authenticated: .constant(false))
    }
}
#endif
