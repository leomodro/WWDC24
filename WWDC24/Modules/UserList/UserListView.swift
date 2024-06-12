//
//  UserListView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

struct UserListView: View {
    
    @Environment(UserListViewModel.self) private var viewModel: UserListViewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            List(viewModel.users, id: \.id) { user in
                Text(user.fullName)
            }
            .alert(with: $viewModel.alert)
            .navigationTitle("Users")
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

#Preview(traits: .userListPreview) {
    UserListView()
}
