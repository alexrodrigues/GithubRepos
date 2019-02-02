//
//  Repo.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

struct Repo: Codable {

    var name: String?
    var stars: Int?
    var owner: Owner?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stars = "stargazers_count"
        case owner
    }
}
