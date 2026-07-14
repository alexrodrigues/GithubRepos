//
//  GithubService.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 30/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

class GithubService {

    func performFetch() async throws -> GithubResponse? {
        guard let url = URL(string: Endpoints.home.rawValue ) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try? JSONDecoder().decode(GithubResponse.self, from: data)
        return response
    }
}

enum Endpoints: String {
    case home = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
}
