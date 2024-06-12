//
//  Service.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case wrongDecoding
    case unknown
}

@MainActor
protocol APIClient {
    func fetch<T: Codable>(_ path: String) async throws -> T
}

extension APIClient {
    func fetch<T: Codable>(_ path: String) async throws -> T {
        guard let url = URL(string: path) else { throw ServiceError.invalidURL }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw ServiceError.wrongDecoding }
            return decodedResponse
        } catch {
            throw ServiceError.unknown
        }
    }
}

@MainActor
protocol Service {
    func fetchUsers() async throws -> [User]
}

final class UserService: APIClient, Service {
    func fetchUsers() async throws -> [User] {
        let response: UserResponse = try await self.fetch("http://dummyjson.com/users")
        return response.users
    }
}
