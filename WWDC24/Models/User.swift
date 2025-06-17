//
//  User.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import Foundation
import SwiftUI
import Playgrounds

struct UserResponse: @MainActor Codable, Sendable {
    let users: [User]
    let total: Int
    let skip: Int
    let limit: Int
}

struct User: @MainActor Codable, Sendable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let gender: Gender
    let role: User.Role
    
    enum Role: String, Codable, Sendable {
        case admin, moderator, user
        
        var color: Color {
            switch self {
            case .admin:
                    .orange
            case .moderator:
                    .indigo
            case .user:
                    .red
            }
        }
    }
}

enum Gender: String, Codable, Sendable {
    case male, female
}

extension User {
    var fullName: String {
        firstName + " " + lastName
    }
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
             formatter.style = .abbreviated
             return formatter.string(from: components)
        }
        return "-"
    }
}

#Playground {
    let user = User(id: 1, firstName: "Leonardo", lastName: "Modro", age: 28, gender: .male, role: .admin)
    
    let initials = user.initials
    print(initials)
    
    let fullName = user.fullName
    print(fullName)
}
