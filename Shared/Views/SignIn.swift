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
        let user = User(first: credentials.fullName?.givenName ?? "",
                        last: credentials.fullName?.familyName ?? "",
                        email: credentials.email ?? "",
                        appleID: credentials.user,
                        rank: User.Rank(id: 1, title: "basic"))
        Task {
            do {
                if let response = try await network.create(user: user) {
                    UserDefaults.standard.set(response, forKey: AppUser.persistenceKey)

                    let persisted = try JSONDecoder().decode(User.self, from: response)
                    self.user.update(first: persisted.given,
                                      last: persisted.family,
                                     email: persisted.email,
                                     appleID: persisted.id,
                                     rank: persisted.rank)
                }
            } catch NetworkCom.NetworkErrors.database {
                print("Database operation could not be completed. Check database log.")
            } catch NetworkCom.NetworkErrors.request {
                print("Bad request.")
            } catch {
                print("Could not decode response.")
            }
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
