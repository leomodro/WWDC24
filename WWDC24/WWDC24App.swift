//
//  WWDC24App.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

@main
struct WWDC24App: App {
    @State private var viewModel = UserListViewModel(service: UserService())
    
    var body: some Scene {
        WindowGroup {
            UserListView()
                .environment(viewModel)
        }
    }
}
