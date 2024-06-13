//
//  UserListView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

struct UserListView: View {
    
    @Environment(UserListViewModel.self) private var viewModel: UserListViewModel
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.users, id: \.id) { user in
                        card(for: user)
                    }
                }
                .padding(16)
            }
            .alert(with: $viewModel.alert)
            .navigationTitle("Users")
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

// MARK: - View components
extension UserListView {
    @ViewBuilder
    func card(for user: User) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack {
                Circle()
                    .fill(Color.secondary)
                Text(user.initials)
                    .font(.system(size: 28, weight: .semibold))
            }
            Text(user.fullName)
                .font(.system(size: 18))
                .bold()
                .padding(.top, 16)
            Text("\(user.age) years old")
                .font(.system(size: 14, weight: .light))
                .padding(.bottom, 16)
            
            Label("\(user.role)", systemImage: "tag")
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(user.role.color)
                .padding(6)
                .background(user.role.color.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 4))
        }
        .padding(16)
        .background(.thickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - Preview
#Preview(traits: .userListPreview) {
    UserListView()
}
