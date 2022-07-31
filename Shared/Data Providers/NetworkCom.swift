//
//  Network.swift
//  Meliora
//
//  Created by Yura on 5/30/22.
//

import Foundation
import Joint

final class NetworkCom: ObservableObject {
    public enum NetworkErrors: Error {
        case request, database
    }
    
    public enum DatabaseErrors: Error {
        case create, find
    }
    
    func compose(endpoint: String, body: Data?, method: String) -> URLRequest? {
        guard
            let apiServerURL = URL(string: JointSession.apiServer + endpoint)
        else { return nil }
        
        var request = URLRequest(url: apiServerURL)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = body
        request.httpMethod = method
        
        return request
    }
}

extension NetworkCom {
    /// Add a new user entry to the database.
    /// - Parameter user: User info.
    /// - Returns: Response data.
    func create(user: User) async throws -> Data? {
        guard
            let request = compose(endpoint: "/user/create",
                                    body: try JSONEncoder().encode(user),
                                    method: "POST")
        else { return nil }
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            
            guard
                let response = urlResponse as? HTTPURLResponse, response.statusCode == 200
            else { throw NetworkErrors.request }
            
            return data
        } catch {
            throw DatabaseErrors.create
        }
    }
    
    /// Find a user in the database.
    /// - Parameter predicate: Search string.
    /// - Returns: Matching users.
    func find(matching query: String, offset: String?) async throws -> [User] {
        guard
            var componenets = URLComponents(string: JointSession.apiServer + "/user/find")
        else { return [] }
        
        componenets.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "offset", value: offset)
        ]
        
//        do {
//            let (data, urlResponse) = try await URLSession.shared.data(from: componenets.url!)
//
//            guard
//                let response = urlResponse as? HTTPURLResponse, response.statusCode == 200
//            else { throw NetworkErrors.request }
//
//            return try JSONDecoder().decode([User].self, from: data)
//        } catch {
//            throw DatabaseErrors.find
//        }
        return try await mockMatchingUsers(matching: query, offset: offset)
    }
}

extension NetworkCom {
    private func mockMatchingUsers(matching query: String, offset: String?) async throws -> [User] {
        guard
            var componenets = URLComponents(string: JointSession.apiServer + "/user/find")
        else { return [] }
        
        componenets.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "offset", value: offset)
        ]
        let users = UserStore().users
        
        return users.filter { user in
            user.given.lowercased().contains(query.lowercased()) || user.family.lowercased().contains(query.lowercased())
        }
    }
}
