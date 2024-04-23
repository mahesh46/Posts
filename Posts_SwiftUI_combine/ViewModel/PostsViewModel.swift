//
//  PostsViewModel.swift
//  posts_swiftui_err
//
//  Created by mahesh lad on 23/04/2024.
//

import Foundation
import Combine

// MARK: - View Model
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String = ""
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchPosts()
    }

    func fetchPosts() {
        let networkService = NetworkService()
        networkService.fetchPosts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    break
                }
            }, receiveValue: { posts in
                self.posts = posts
            })
            .store(in: &cancellables)
    }
}
