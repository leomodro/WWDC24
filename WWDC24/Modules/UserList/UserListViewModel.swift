//
//  UserListViewModel.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

@MainActor
class UserListViewModel: ObservableObject {
    
    let service: UserServiceable
    
    @Published var users: [User] = []
    @Published var alert: Alerts?
    
    init(service: UserServiceable) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            users = try await service.fetchUsers().sorted(by: \.fullName)
        } catch {
            print(error)
            alert = .unableToFetchData
        }
    }
    
}
