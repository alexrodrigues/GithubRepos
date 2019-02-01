//
//  GithubResponseFactory.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 31/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

class GithubResponseFactory {
    
    func factor(githubResponse: GithubResponse) -> [RepoViewModel] {
        var response = [RepoViewModel]()
        guard let repos = githubResponse.items else { return [RepoViewModel]() }
        response = repos.prefix(10).map { RepoViewModel(repo: $0) }
        return response
    }
}
