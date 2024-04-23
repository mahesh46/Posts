//
//  Posts.swift
//  posts_swiftui_err
//
//  Created by mahesh lad on 23/04/2024.
//


// MARK: - Data Model
struct Post: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let body: String
    
    // Add this static function to conform to Equatable
        static func == (lhs: Post, rhs: Post) -> Bool {
            return lhs.id == rhs.id && lhs.title == rhs.title && lhs.body == rhs.body
        }
}

// MARK: - Data Model Tests
#if DEBUG
extension Post {
    static let mockPosts = [
        Post(id: 1, title: "Post 1", body: "This is the body of post 1."),
        Post(id: 2, title: "Post 2", body: "This is the body of post 2."),
        Post(id: 3, title: "Post 3", body: "This is the body of post 3.")
    ]
}
#endif
