//
//  UserListViewModel.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import Observation
import SwiftUI

@MainActor
@Observable class UserListViewModel {
    
    let service: UserServiceable
    
    var users: [User] = []
    var alert: Alerts?
    
    init(service: UserServiceable) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            users = try await service.fetchUsers().sorted(by: \.fullName)
        } catch {
            alert = .unableToFetchData
        }
    }
    
}
