//
//  MainTabView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 11/06/25.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var viewModel = UserListViewModel(service: UserService())
    @State private var searchViewModel = SearchViewModel()
    
    var body: some View {
        TabView {
            Tab("Users", systemImage: "person.fill", role: .none) {
                UserListView()
                    .environment(\.userListViewModel, viewModel)
            }
            
            Tab("WWDCs", systemImage: "applelogo", role: .none) {
                WWDCsView()
            }
            
            Tab(role: .search) {
                SearchView()
                    .environment(\.searchViewModel, searchViewModel)
            }
        }
        .minimizableTabView()
    }
}

#Preview {
    MainTabView()
}
