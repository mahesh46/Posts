//
//  NetworkService.swift
//  posts_swiftui_err
//
//  Created by mahesh lad on 23/04/2024.
//

import Foundation
//import Combine

// MARK: - Network Service
class NetworkService {
//    func fetchPosts() -> AnyPublisher<[Post], Error> {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .map { $0.data }
//            .decode(type: [Post].self, decoder: JSONDecoder())
//            .eraseToAnyPublisher()
//    }
    func fetchPosts() async throws -> [Post] {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let posts = try JSONDecoder().decode([Post].self, from: data)
        return posts
    }
}

// MARK: - Network Service Tests
#if DEBUG
extension NetworkService {
    static let mockPosts: [Post] = Post.mockPosts

//    func fetchMockPosts() -> AnyPublisher<[Post], Error> {
//        Just(NetworkService.mockPosts)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
//    }
    func fetchMockPosts() async throws -> [Post] {
           return NetworkService.mockPosts
       }
}
#endif
