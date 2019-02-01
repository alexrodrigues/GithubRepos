//
//  RepoViewModel.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 31/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

struct RepoViewModel {
    
    var repository: Repo
    
    var ownerName: String {
        return repository.owner?.name ?? ""
    }
    
    var ownerImage: String {
        return repository.owner?.profileImageUrl ?? ""
    }
    
    var repoName: String {
        return repository.name ?? ""
    }
    
    var totalStars: Int {
        return repository.stars ?? 0
    }
    
    
    init(repo: Repo) {
        repository = repo
    }
}
