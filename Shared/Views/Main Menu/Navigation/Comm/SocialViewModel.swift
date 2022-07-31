//
//  SocialViewModel.swift
//  Meliora
//
//  Created by Yura on 7/29/22.
//

import Foundation
import Joint
import Combine

class SocialViewModel: ObservableObject {
    @Published var searchFriendsText: String = ""
    @Published private (set) var matchingUsers: [User] = []
    
    var subscription = [AnyCancellable]()
    let network = NetworkCom()
    
    init() {
        $searchFriendsText
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .handleEvents(receiveOutput: { searchString in
                
            })
            .sink { searchString in
                self.searchUsers(matching: searchString)
            }
            .store(in: &subscription)
    }
    
    func searchUsers(matching query: String) {
        if !query.isEmpty {
            Task { @MainActor in
                self.matchingUsers = try await self.network.find(matching: query, offset: nil)
                
            }
        } else {
            self.matchingUsers = []
        }
    }
}
