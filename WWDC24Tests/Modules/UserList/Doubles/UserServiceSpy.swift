//
//  UserServiceSpy.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

@testable import WWDC24

final class UserServiceSpy: UserServiceable {
    
    nonisolated(unsafe) private(set) var fetchUsersDataCalled = false
    nonisolated(unsafe) private(set) var fetchUsersCallCount = 0
    nonisolated(unsafe) var fetchUsersDataReturned: [User] = []
    nonisolated(unsafe) var fetchUsersThrowError: ServiceError?
    
    func fetchUsers() async throws -> [User] {
        if let fetchUsersThrowError { throw fetchUsersThrowError }
        fetchUsersDataCalled = true
        fetchUsersCallCount += 1
        return fetchUsersDataReturned
    }
}
