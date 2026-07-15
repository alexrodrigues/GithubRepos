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

    @CasePathable
    enum Action: Equatable {
        case onAppear
        case refresh
        case onClick
        case fetchResponseSuccess([RepositoryResponse])
        case fetchResponseFailure(String)
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
                    do {
                        let repos = try await githubClient.fetchRepos()
                        await send(.fetchResponseSuccess(repos))
                    } catch {
                        await send(.fetchResponseFailure(error.localizedDescription))
                    }
                }

            case .onClick:
                state.errorMessage = "Feature under construction 🚧"
                return .none

            case let .fetchResponseSuccess(repos):
                state.isLoading = false
                state.repos = repos
                return .none

            case let .fetchResponseFailure(message):
                state.isLoading = false
                state.errorMessage = message
                return .none

            case .dismissError:
                state.errorMessage = nil
                return .none
            }
        }
    }
}
