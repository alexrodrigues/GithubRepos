//
//  GithubService.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 30/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation
import RxSwift

class GithubService {

    func performFetch() -> Observable<[RepoViewModel]> {
        return Api<GithubResponse>()
            .requestRx(endpoint: .home)
            .map { GithubResponseFactory().factor(githubResponse: $0) }
    }
}
