//
//  Endpoints.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

enum Endpoints: String {
    case home = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
}
