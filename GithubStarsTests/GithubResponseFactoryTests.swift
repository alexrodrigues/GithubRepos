//
//  GithubResponseFactoryTests.swift
//  GithubStarsTests
//

import XCTest

@testable import GithubStars

final class GithubResponseFactoryTests: XCTestCase {
    func testFactorReturnsEmptyWhenItemsMissing() {
        let result = GithubResponseFactory().factor(githubResponse: GithubResponse(items: nil))
        XCTAssertTrue(result.isEmpty)
    }

    func testFactorMapsRepositories() {
        let response = GithubResponse(
            items: [
                Repo(name: "swift", stars: 100, owner: Owner(name: "swiftlang", profileImageUrl: nil)),
            ]
        )

        let result = GithubResponseFactory().factor(githubResponse: response)

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.name, "swift")
        XCTAssertEqual(result.first?.totalStars, 100)
        XCTAssertEqual(result.first?.ownerName, "swiftlang")
    }
}
