//
//  AppUser.swift
//  Meliora (iOS)
//
//  Created by Yura on 6/2/22.
//

import Foundation
import Joint

class AppUser: User {
    static let persistenceKey = "Meliora.User.Auth"
    
    override init(first: String = "", last: String = "", email: String = "", appleID: String = "", rank: User.Rank = Rank(id: 1), createdAt: Date = Date()) {
        if let data = UserDefaults.standard.data(forKey: AppUser.persistenceKey) {
            if let user = try? JSONDecoder().decode(User.self, from: data) {
                print("Initializing user from local storage.")
                
                super.init(first: user.given, last: user.family, email: user.email, appleID: user.id, rank: user.rank)
                
                return
            } else {
                print("Could not decode user.", String.init(data: data, encoding: .utf8) ?? "")
            }
        }
        
        super.init(first: first, last: last, email: email, appleID: appleID, rank: rank)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
