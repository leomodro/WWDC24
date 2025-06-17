//
//  UserListView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 12/06/24.
//

import SwiftUI

struct UserListView: View {
    
    @State var searchTerm: String = ""
    @Environment(\.userListViewModel) private var viewModel
    @Namespace var userDetail
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        @Bindable var viewModel = viewModel
        NavigationStack {
            switch viewModel.state {
            case .loading:
                loadingView
            case .empty:
                emptyView
            case .loaded:
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(viewModel.users, id: \.id) { user in
                            row(for: user)
                        }
                    }
                    .padding(16)
                }
//                .hardScrollEdgeEffect() // Sets hard edge effect style on scrolled content
                .alert(with: $viewModel.alert)
                .navigationTitle(.users)
            }
        }
        .task {
            await viewModel.fetchUsers()
        }
    }
}

// MARK: - View components
extension UserListView {
    var loadingView: some View {
        Image(systemName: "swift")
            .symbolEffect(.pulse, isActive: true)
            .font(.system(size: 72))
            .foregroundStyle(.red)
    }
    
    var emptyView: some View {
        ContentUnavailableView(.noUsersFound,
                               systemImage: "person.crop.circle.badge.questionmark",
                               description: Text(.weCouldntFindAnyUsersAtThisTimeTryAgainLater))
    }
    
    @ViewBuilder 
    func row(for user: User) -> some View {
        NavigationLink {
            Text(user.fullName)
                .font(.largeTitle)
                .navigationTransition(.zoom(sourceID: user.id, in: userDetail))
        } label: {
            card(for: user)
        }
        .matchedTransitionSource(id: user.id, in: userDetail)
        .buttonStyle(.plain)
    }
    
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
            
            Label(user.role.rawValue, systemImage: "tag")
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
        .preferredColorScheme(.dark)
}
