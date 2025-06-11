//
//  UserService.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

protocol UserServiceable {
    func fetchUsers() async throws -> [User]
}

final class UserService: APIClient, UserServiceable {
    func fetchUsers() async throws -> [User] {
        let response: UserResponse = try await self.fetch("http://dummyjson.com/users")
        return response.users
    }
}
