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

    func testFactorMapsMultipleRepositories() {
        let response = GithubResponse(
            items: [
                Repo(name: "swift", stars: 100, owner: Owner(name: "swiftlang", profileImageUrl: nil)),
                Repo(name: "Alamofire", stars: 40_000, owner: Owner(name: "Alamofire", profileImageUrl: "https://example.com/a.png")),
            ]
        )

        let result = GithubResponseFactory().factor(githubResponse: response)

        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result.map(\.name), ["swift", "Alamofire"])
        XCTAssertEqual(result.map(\.totalStars), [100, 40_000])
        XCTAssertEqual(result[1].ownerImage, "https://example.com/a.png")
    }

    func testRepositoryResponseUsesDefaultsForMissingFields() {
        let response = RepositoryResponse(
            repo: Repo(name: nil, stars: nil, owner: nil)
        )

        XCTAssertEqual(response.name, "")
        XCTAssertEqual(response.totalStars, 0)
        XCTAssertEqual(response.ownerName, "")
        XCTAssertEqual(response.ownerImage, "")
    }
}
