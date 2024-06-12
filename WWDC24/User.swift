//
//  User.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import Foundation

struct UserResponse: Codable, Sendable {
    let users: [User]
    let total: Int
    let skip: Int
    let limit: Int
}

struct User: Codable, Sendable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let gender: Gender
    let role: User.Role
    
    enum Role: String, Codable, Sendable {
        case admin, moderator, user
    }
}

enum Gender: String, Codable, Sendable {
    case male, female
}
