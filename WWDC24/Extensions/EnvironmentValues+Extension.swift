//
//  EnvironmentValues+Extension.swift
//  WWDC24
//
//  Created by Leonardo Modro on 17/06/25.
//

import SwiftUI

extension EnvironmentValues {
    var userListViewModel: UserListViewModel {
        get { self[UserListViewModelKey.self] }
        set { self[UserListViewModelKey.self] = newValue }
    }
}


private struct UserListViewModelKey: EnvironmentKey {
    static let defaultValue: UserListViewModel = UserListViewModel(service: UserService())
}
