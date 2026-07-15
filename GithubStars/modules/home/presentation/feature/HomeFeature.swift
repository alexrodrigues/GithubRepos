//
//  HomeFeature.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 15/07/26.
//  Copyright © 2026 Alex Rodrigues. All rights reserved.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var repos: [RepositoryResponse] = []
        var isLoading = false
        var errorMessage: String?
    }

    enum Action {
        case onAppear
        case refresh
        case onClick
        case fetchResponse(Result<[RepositoryResponse], any Error>)
        case dismissError
    }

    @Dependency(\.githubClient) var githubClient

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear, .refresh:
                state.isLoading = true
                state.errorMessage = nil
                return .run { send in
                    await send(
                        .fetchResponse(
                            Result { try await githubClient.fetchRepos() }
                        )
                    )
                }
                
            case .onClick:
                state.errorMessage = "Feature under construction 🚧"
                return .none

            case let .fetchResponse(.success(repos)):
                state.isLoading = false
                state.repos = repos
                return .none

            case let .fetchResponse(.failure(error)):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none

            case .dismissError:
                state.errorMessage = nil
                return .none
            }
        }
    }
}
