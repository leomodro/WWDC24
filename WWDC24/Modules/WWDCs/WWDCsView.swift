//
//  WWDCsView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 14/06/25.
//

import SwiftUI

struct WWDCsView: View {
    
    @State private var shouldDisplaySheet: Bool = false
    @State private var shouldDisplayActionSheet: Bool = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List(WWDCItems.allCases, id: \.self) { item in
                HStack {
                    Text(item.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image(systemName: "chevron.forward")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    didTap(item)
                }
            }
            .sheet(isPresented: $shouldDisplaySheet) {
                SampleSheetView()
            }
            .confirmationDialog("".excludeLocalization, isPresented: $shouldDisplayActionSheet) {
                Button(.first) { }
                Button(.second) { }
                Button(.third) { }
            }
            .toolbar {
                toolbarMenu
            }
            .navigationTitle(.wwdcs)
            .navigationDestination(for: WWDCItems.self) { item in
                switch item {
                case .webView:
                    WebViewSampleView()
                default:
                    EmptyView()
                }
            }
        }
    }
    
    private func didTap(_ item: WWDCItems) {
        switch item {
        case .foundationModel:
            break
        case .sheet:
            shouldDisplaySheet.toggle()
        case .actionSheet:
            shouldDisplayActionSheet.toggle()
        case .webView:
            path.append(WWDCItems.webView)
        case .components:
            break
        }
    }
}

// MARK: - View Components
extension WWDCsView {
    var toolbarMenu: some View {
        Menu {
            Button {
                // action
            } label: {
                Text(.first)
                Text(.subtitle)
            }
            Button {
                // action
            } label: {
                Text(.second)
                Text(.subtitle)
            }
            Menu(.actions) {
                Button(.duplicate) { }
                Button(.rename) { }
                Button(.delete) { }
                Menu(.copy) {
                    Button(.copy) { }
                    Button(.copyFormatted) { }
                    Button(.copyLibraryPath) { }
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
        }
    }
}

#Preview {
    WWDCsView()
}
