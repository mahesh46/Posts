//
//  PostsViewModel.swift
//  posts_swiftui_err
//
//  Created by mahesh lad on 23/04/2024.
//

import Foundation
//import Combine

// MARK: - View Model
@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String = ""
   // private var cancellables = Set<AnyCancellable>()

    init() {
       // fetchPosts()
        Task { await fetchPosts() }
    }

//    func fetchPosts() {
//        let networkService = NetworkService()
//        networkService.fetchPosts()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                case .finished:
//                    break
//                }
//            }, receiveValue: { posts in
//                self.posts = posts
//            })
//            .store(in: &cancellables)
//    }
    
    func fetchPosts() async  {
        let networkService = NetworkService()
        do {
            self.posts = try await networkService.fetchPosts()
        } catch (let error) {
            self.errorMessage = error.localizedDescription
       }
    }
}
