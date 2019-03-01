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
    
    typealias RepoCompletion = (_ repos: [RepoViewModel], _ errorMesssage: String) -> Void

    func performFetch(completion: @escaping RepoCompletion) {
        _ = Api<GithubResponse>()
            .requestRx(endpoint: .home)
            .subscribe(onNext: { result in
                completion(GithubResponseFactory().factor(githubResponse: result), "")
            }, onError: { (error) in
                completion([RepoViewModel](), error.localizedDescription)
            }, onCompleted: {
            }) {
            }
        
    }
}
