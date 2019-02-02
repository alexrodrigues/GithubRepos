//
//  GithubService.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 30/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

class GithubService {
    
    typealias RepoCompletion = (_ repos: [RepoViewModel], _ errorMesssage: String) -> Void

    func performFetch(completion: @escaping RepoCompletion) {
        Api<GithubResponse>().requestObject(endpoint: .home) { (result) -> (Void) in
            switch result {
            case .success(let response):
                completion(GithubResponseFactory().factor(githubResponse: response), "")
            case .error(let errorMessage):
                completion([RepoViewModel](), errorMessage)
            }
        }
    }
}
