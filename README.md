# Posts
## Posts_SwiftUi_combine


Swiftui program with network call and error handling to show a list of posts or show network error


## Test script added

  ## Test decodeing

  > Data Model Tests: Inside the #if DEBUG block, an extension on the Post struct is added with a static mockPosts array containing sample post data. This can be used for testing purposes.

  > Network Service Tests: Inside the #if DEBUG block, an extension on the NetworkService class is added with a static mockPosts array and a fetchMockPosts function. The fetchMockPosts   function returns a publisher that emits the mockPosts array, allowing you to test the network service without making an actual network request.


  > View Model: In the fetchPosts function of the PostsViewModel, a conditional compilation block is added to use either the fetchMockPosts function (in debug mode) or the fetchPosts function (in release mode) from the NetworkService.


With these changes, when you run the app in debug mode (e.g., in the Xcode simulator or on a debug device), it will use the mock data for testing purposes. In release mode, it will make an actual network request to fetch the posts.

  ## Test networkservice

   > testFetchPostsSuccess:
  This test case verifies that the fetchPosts function successfully fetches posts from the API.
  It sets up an expectation and uses the sink operator to handle the publisher's output.
  If the posts array is not empty, the test passes; otherwise, it fails.
  
  > testFetchPostsFailure:
  This test case verifies that the fetchPosts function handles network errors correctly.
  It sets up an expectation and uses the URLProtocolMock class to simulate a network error (404 Not Found).
  If the publisher emits a failure, the test passes; otherwise, it fails.
  
  > testFetchMockPostsSuccess:
  This test case verifies that the fetchMockPosts function returns the expected mock posts.
  It sets up an expectation and uses the sink operator to handle the publisher's output.
  If the received posts match the expected mockPosts array, the test passes; otherwise, it fails.


<img width="376" alt="Screenshot 2024-04-23 at 09 52 26" src="https://github.com/mahesh46/Posts/assets/3464277/ae01581c-e94e-4df6-a720-2b90fb7b4376">
