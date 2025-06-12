//
//  MainTabView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 11/06/25.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var viewModel = UserListViewModel(service: UserService())
    
    var body: some View {
        TabView {
            Tab("Users", systemImage: "person.fill", role: .none) {
                UserListView()
                    .environment(viewModel)
            }
            
            Tab("WWDCs", systemImage: "applelogo", role: .none) {
                Text(.other)
            }
            
            Tab(role: .search) {
                Text(.search)
            }
        }
        .minimizableTabView()
        .tint(.red)
    }
}

#Preview {
    MainTabView()
}
