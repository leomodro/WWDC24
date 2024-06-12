//
//  UserListPreview.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

struct UserListPreview: PreviewModifier {
    struct MockUserService: UserServiceable {
        let users: [User] = [
            User(id: 1, firstName: "John", lastName: "Doe", age: 27, gender: .male, role: .user),
            User(id: 2, firstName: "Jane", lastName: "Doe", age: 20, gender: .female, role: .user),
            User(id: 3, firstName: "Albert", lastName: "Doe", age: 30, gender: .male, role: .admin),
            User(id: 4, firstName: "Steve", lastName: "Jobs", age: 40, gender: .male, role: .moderator)
        ]
        
        func fetchUsers() async throws -> [User] {
            return users
        }
    }
    static func makeSharedContext() throws -> UserListViewModel {
        let viewModel = UserListViewModel(service: MockUserService())
        return viewModel
    }

    func body(content: Content, context: UserListViewModel) -> some View {
        content.environment(context)
    }
 }
