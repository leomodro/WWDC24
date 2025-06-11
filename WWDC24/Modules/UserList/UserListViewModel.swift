//
//  UserListViewModel.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import Observation
import SwiftUI

enum ViewState {
    case loading, empty, loaded
}

@Observable class UserListViewModel {
    
    let service: UserServiceable
    
    var users: [User] = []
    var state: ViewState = .loading
    var alert: Alerts?
    
    init(service: UserServiceable) {
        self.service = service
    }
    
    func fetchUsers() async {
        do {
            users = try await service.fetchUsers().sorted(by: \.fullName)
            withAnimation {
                state = users.isEmpty ? .empty : .loaded
            }
        } catch {
            withAnimation {
                state = .empty
            }
            alert = .unableToFetchData
        }
    }
    
}
