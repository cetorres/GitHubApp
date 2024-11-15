//
//  TestAppTests.swift
//  TestAppTests
//
//  Created by Carlos E. Torres on 6/25/24.
//

import XCTest
@testable import GitHubApp

final class GitHubAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWebServiceGetUser() async throws {
        let userLogin = "cetorres"
        let user = try await GitHubWebService.shared.getUser(userLogin: userLogin)
        XCTAssertEqual(user.login, userLogin)
    }

    func testWebServiceGetFollowers() async throws {
        let userLogin = "cetorres"
        let followerLogin = "ribeiro"
        let followers = try await GitHubWebService.shared.getFollowers(userLogin: userLogin)
        XCTAssertTrue(followers.contains(where: { $0.login.lowercased() == followerLogin }))
    }
    
    func testWebServiceGetRepos() async throws {
        let userLogin = "cetorres"
        let repoName = "cetorres"
        let repos = try await GitHubWebService.shared.getRepos(userLogin: userLogin)
        XCTAssertTrue(repos.contains(where: { $0.name.lowercased() == repoName }))
    }
}
