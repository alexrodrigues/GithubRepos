//
//  HomeFeatureTests.swift
//  GithubStarsTests
//

import ComposableArchitecture
import XCTest

@testable import GithubStars

@MainActor
final class HomeFeatureTests: XCTestCase {
    private let mockRepos = [
        RepositoryResponse(
            repo: Repo(
                name: "Hello-World",
                stars: 42,
                owner: Owner(name: "octocat", profileImageUrl: "https://example.com/avatar.png")
            )
        ),
    ]

    func testOnAppearSuccess() async {
        let store = TestStore(initialState: HomeFeature.State()) {
            HomeFeature()
        } withDependencies: {
            $0.githubClient.fetchRepos = { self.mockRepos }
        }

        await store.send(.onAppear) {
            $0.isLoading = true
            $0.errorMessage = nil
        }

        await store.receive(\.fetchResponseSuccess) {
            $0.isLoading = false
            $0.repos = self.mockRepos
        }
    }

    func testOnAppearFailure() async {
        let store = TestStore(initialState: HomeFeature.State()) {
            HomeFeature()
        } withDependencies: {
            $0.githubClient.fetchRepos = { throw URLError(.notConnectedToInternet) }
        }

        await store.send(.onAppear) {
            $0.isLoading = true
            $0.errorMessage = nil
        }

        await store.receive(\.fetchResponseFailure) {
            $0.isLoading = false
            $0.errorMessage = URLError(.notConnectedToInternet).localizedDescription
        }
    }

    func testOnClickShowsPlaceholderMessage() async {
        let store = TestStore(initialState: HomeFeature.State()) {
            HomeFeature()
        }

        await store.send(.onClick) {
            $0.errorMessage = "Feature under construction 🚧"
        }
    }

    func testDismissError() async {
        let store = TestStore(
            initialState: HomeFeature.State(errorMessage: "Something went wrong")
        ) {
            HomeFeature()
        }

        await store.send(.dismissError) {
            $0.errorMessage = nil
        }
    }
}
