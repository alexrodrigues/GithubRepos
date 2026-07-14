//
//  GIthubResponse.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 29/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

struct GithubResponse:Codable {
    
    var items: [Repo]?
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
}
