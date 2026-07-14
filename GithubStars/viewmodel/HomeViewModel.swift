//
//  HomeViewModel.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 07/03/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

class HomeViewModel {

    private let service = GithubService()

    func fetch() async throws -> [RepositoryResponse] {
        guard let response = try await service.performFetch() else {
            return []
        }
        return GithubResponseFactory().factor(githubResponse: response)
    }
}
