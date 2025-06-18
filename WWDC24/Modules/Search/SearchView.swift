//
//  SearchView.swift
//  WWDC24
//
//  Created by Leonardo Modro on 17/06/25.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.searchViewModel) private var viewModel
    @State private var searchText: String = ""
    
    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .trailing) {
                ScrollView {
                    imageGrid
                }
                .searchable(text: $searchText)
            }
            .task {
                await viewModel.loadImages()
            }
            .safeAreaInset(edge: .bottom) {
                glassEffectView
            }
            .ignoresSafeArea(.keyboard)
            .navigationTitle(.search)
        }
    }
}

// MARK: - View Components
extension SearchView {
    var imageGrid: some View {
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(viewModel.images, id: \.id) { image in
                if let thumbnail = image.thumbnailImage {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .transition(.scale)
                } else {
                    ProgressView()
                        .frame(width: 80, height: 80)
                }
            }
        }
        .padding(8)
    }
    
    @ViewBuilder var glassEffectView: some View {
        if #available(iOS 26.0, *) {
            HStack {
                Spacer()
                GlassSampleView()
            }
        }
    }
}

#Preview {
    SearchView()
}
