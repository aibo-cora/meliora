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
    
    func create(user: User) async throws -> Data? {
        guard let apiServerURL = URL(string: JointSession.apiServer + "/user/create") else { return nil }
        
        var request = URLRequest(url: apiServerURL)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        request.httpBody = try JSONEncoder().encode(user)
        request.httpMethod = "POST"
        
        do {
            let (data, urlResponse) = try await URLSession.shared.data(for: request)
            guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkErrors.request
            }
            
            return data
        } catch {
            print(error.localizedDescription)
            throw NetworkErrors.database
        }
    }
}
