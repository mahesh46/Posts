//
//  Posts_SwiftUI_combineTests.swift
//  Posts_SwiftUI_combineTests
//
//  Created by mahesh lad on 23/04/2024.
//

import XCTest
@testable import Posts_SwiftUI_combine

final class Posts_SwiftUI_combineTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

   
    func testPostDecoding() throws {
            let jsonData = """
            [
                {
                    "id": 1,
                    "title": "Post 1",
                    "body": "This is the body of post 1."
                },
                {
                    "id": 2,
                    "title": "Post 2",
                    "body": "This is the body of post 2."
                }
            ]
            """.data(using: .utf8)!

            let posts = try JSONDecoder().decode([Post].self, from: jsonData)

            XCTAssertEqual(posts.count, 2)
            XCTAssertEqual(posts[0].id, 1)
            XCTAssertEqual(posts[0].title, "Post 1")
            XCTAssertEqual(posts[0].body, "This is the body of post 1.")
            XCTAssertEqual(posts[1].id, 2)
            XCTAssertEqual(posts[1].title, "Post 2")
            XCTAssertEqual(posts[1].body, "This is the body of post 2.")
    }
    

}
