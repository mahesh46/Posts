//
//  NetworkServiceTests.swift
//  Posts_SwiftUI_combineTests
//
//  Created by mahesh lad on 23/04/2024.
//

import Combine
import XCTest
@testable import Posts_SwiftUI_combine

final class NetworkServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func testFetchPostsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch posts success")
        let networkService = NetworkService()

        networkService.fetchPosts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error fetching posts: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { posts in
                XCTAssertFalse(posts.isEmpty, "Posts array should not be empty")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchPostsFailure() {
        let expectation = XCTestExpectation(description: "Fetch posts failure")
        let networkService = NetworkService()
        let invalidURL = URL(string: "https://invalid.url")!

        URLProtocolMock.requestHandler = { request in
            let response = HTTPURLResponse(url: invalidURL, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        networkService.fetchPosts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    expectation.fulfill()
                case .finished:
                    XCTFail("Fetch posts should fail with an invalid URL")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }

    func testFetchMockPostsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch mock posts success")
        let networkService = NetworkService()

        networkService.fetchMockPosts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Error fetching mock posts: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { posts in
                XCTAssertEqual(posts, NetworkService.mockPosts, "Mock posts should match expected values")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
    }
}

// MARK: - URLProtocolMock
class URLProtocolMock: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Handler is unavailable.")
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
    }
