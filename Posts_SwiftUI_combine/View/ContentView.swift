//
//  ContentView.swift
//  Posts_SwiftUI_combine
//
//  Created by mahesh lad on 23/04/2024.
//

import SwiftUI

// MARK: - View
struct ContentView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationView {
            Group {
                if !viewModel.errorMessage.isEmpty {
                    Text(viewModel.errorMessage)
                        .padding()
                } else {
                    List(viewModel.posts) { post in
                        LazyVStack(alignment: .leading) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.body)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .navigationBarTitle("Posts")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
