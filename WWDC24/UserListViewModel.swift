//
//  UserListViewModel.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

@MainActor
class UserListViewModel: ObservableObject {
    
    let service: Service
    
    @Published var users: [User] = []
    
    init(service: Service) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            users = try await service.fetchUsers()
        } catch {
            print(error)
        }
    }
    
}
