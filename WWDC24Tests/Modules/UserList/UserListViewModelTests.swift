//
//  UserListViewModelTests.swift
//  WWDC24Tests
//
//  Created by Leonardo Modro on 12/06/24.
//

import Testing
@testable import WWDC24

@Suite("User List") struct UserListViewModelTests {

    @Test("Fetched users", .tags(.requests))
    func usersFetched() async throws {
        let (serviceSpy, sut) = await makeSUT()
        
        serviceSpy.fetchUsersDataReturned = [User.fixture()]
        await sut.fetchUsers()
        let userCount = try #require(await sut.users.count)
        
        #expect(serviceSpy.fetchUsersDataCalled)
        #expect(serviceSpy.fetchUsersCallCount == 1)
        #expect(userCount == 1)
    }
    
    @Test("Error fetching users", .tags(.requests))
    func fetchUserThrowingError() async throws {
        let (serviceSpy, sut) = await makeSUT()
        
        serviceSpy.fetchUsersThrowError = .unknown
        await sut.fetchUsers()
        
        let alert = try #require(await sut.alert)
        
        #expect(alert == .unableToFetchData)
    }
    
    @Test("Empty users", .tags(.requests))
    func fetchUserEmptyReturn() async throws {
        let (_, sut) = await makeSUT()
        
        await sut.fetchUsers()
        
        let alert = try #require(await sut.state)
        
        #expect(alert == .empty)
    }
    
    @Test("Users sorted by full name", .tags(.sorting), arguments: [[
        User.fixture(),
        User.fixture(id: 2, firstName: "Jane", lastName: "Doe", age: 20, gender: .female),
        User.fixture(id: 3, firstName: "Albert", lastName: "Doe", age: 30, role: .admin),
        User.fixture(id: 4, firstName: "Steve", lastName: "Jobs", age: 40, role: .moderator)
    ]])
    func usersSortedByFullName(_ users: [User]) async throws {
        let (serviceSpy, sut) = await makeSUT()
        
        serviceSpy.fetchUsersDataReturned = users
        await sut.fetchUsers()
        let fetchUsers = try #require(await sut.users)
        let firstUser = try #require(fetchUsers.first)
        
        #expect(serviceSpy.fetchUsersDataCalled)
        #expect(serviceSpy.fetchUsersCallCount == 1)
        #expect(fetchUsers.count == 4)
        #expect(firstUser.fullName == "Albert Doe")
        #expect(firstUser.initials == "AD")
    }
    
    @Test("Users reverse sorted by full name", .disabled("Order shouldn't be reversed"))
    func usersSortedReverse() async throws {
        // You can disable a test
    }

}

// MARK: - SUT
extension UserListViewModelTests {
    func makeSUT() async -> (serviceSpy: UserServiceSpy, sut: UserListViewModel) {
        let serviceSpy = await UserServiceSpy()
        let sut = await UserListViewModel(service: serviceSpy)
        return (serviceSpy, sut)
    }
}
