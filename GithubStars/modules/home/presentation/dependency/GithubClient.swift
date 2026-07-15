//
//  GithubClient.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 15/07/26.
//  Copyright © 2026 Alex Rodrigues. All rights reserved.
//

import ComposableArchitecture
import Foundation

@DependencyClient
struct GithubClient: Sendable {
    var fetchRepos: @Sendable () async throws -> [RepositoryResponse] = { [] }
}

extension GithubClient: DependencyKey {
    static let liveValue = Self(
        fetchRepos: {
            let service = GithubService()
            guard let response = try await service.performFetch() else { return [] }
            return GithubResponseFactory().factor(githubResponse: response)
        }
    )

    static let previewValue = Self(
        fetchRepos: {
            [
                RepositoryResponse(
                    repo: Repo(
                        name: "Hello-World",
                        stars: 42,
                        owner: Owner(
                            name: "octocat",
                            profileImageUrl: "https://avatars.githubusercontent.com/u/583231?v=4"
                        )
                    )
                ),
                RepositoryResponse(
                    repo: Repo(
                        name: "swift",
                        stars: 68_000,
                        owner: Owner(
                            name: "swiftlang",
                            profileImageUrl: "https://avatars.githubusercontent.com/u/42816656?v=4"
                        )
                    )
                ),
            ]
        }
    )
}

extension DependencyValues {
    var githubClient: GithubClient {
        get { self[GithubClient.self] }
        set { self[GithubClient.self] = newValue }
    }
}
