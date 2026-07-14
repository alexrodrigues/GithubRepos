//
//  GithubResponseFactory.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 31/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

class GithubResponseFactory {
    
    func factor(githubResponse: GithubResponse) -> [RepositoryResponse] {
        var response = [RepositoryResponse]()
        guard let repos = githubResponse.items else { return [RepositoryResponse]() }
        response = repos.map { RepositoryResponse(repo: $0) }
        return response
    }
}
