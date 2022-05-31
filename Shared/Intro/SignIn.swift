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
    let udUserKey = "Meliora.User.Auth"
    
    @EnvironmentObject var network: NetworkCom

    var user: User
    
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

                    SaveCredentials(credentials: credentials)
                case .failure (let error):
                    print("Authorization failed: " + error.localizedDescription)
                }
            }
            .frame(width: 200, height: 30)
            .font(.title)
        }
    }
    
    /// This should be saved in the keychain or external database to survive app deletion.
    /// - Parameter credentials: Apple auth credentials
    private func SaveCredentials(credentials: ASAuthorizationAppleIDCredential) {
        if let given = credentials.fullName?.givenName, let family = credentials.fullName?.familyName, let email = credentials.email {
            let user = User(first: given,
                            last: family,
                            email: email,
                            appleID: credentials.user,
                            rank: User.UserRank(id: 1, title: "basic"))
            Task {
                do {
                    if let _ = try await network.create(user: user) {
                        UserDefaults.standard.set(try JSONEncoder().encode(user), forKey: udUserKey)
                        
                        self.user.update(first: user.given, last: user.family, email: user.email, appleID: user.id, rank: User.UserRank(id: 1 ))
                    }
                } catch NetworkCom.NetworkErrors.database {
                    print("Database operation could not be completed. Check database log.")
                } catch NetworkCom.NetworkErrors.request {
                    print("Bad request.")
                }
            }
        } else {
            // user info is in the database?
        }
    }
}

#if DEBUG
struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn(user: User())
    }
}
#endif
