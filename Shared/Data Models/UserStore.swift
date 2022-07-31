//
//  File.swift
//  Meliora
//
//  Created by Yura on 7/30/22.
//

import Foundation
import Joint

struct UserStore {
    let users = [
        User(first: "Yura", last: "Filatov", email: "yura.fila@gmail.com", appleID: "UUID-1", rank: User.Rank(id: 1), createdAt: Date()),
        User(first: "Kate", last: "Beckinsale", email: "cute@gmail.com", appleID: "UUID-2", rank: User.Rank(id: 1), createdAt: Date()),
        User(first: "Scarlett", last: "O'Hara", email: "o.hara@gmail.com", appleID: "UUID-3", rank: User.Rank(id: 1), createdAt: Date()),
        User(first: "Rhett", last: "Butler", email: "rhet@gmail.com", appleID: "UUID-4", rank: User.Rank(id: 1), createdAt: Date()),
        User(first: "Sasha", last: "Filatova", email: "sasha@gmail.com", appleID: "UUID-5", rank: User.Rank(id: 1), createdAt: Date()),
        User(first: "Kyle", last: "Filatov", email: "kyle@gmail.com", appleID: "UUID-6", rank: User.Rank(id: 1), createdAt: Date()),
        User(first: "Aurora", last: "Martinez", email: "aurora@gmail.com", appleID: "UUID-7", rank: User.Rank(id: 1), createdAt: Date())
    ]
}
