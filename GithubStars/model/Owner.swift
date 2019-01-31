//
//  Owner.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 30/01/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import Foundation

struct Owner: Codable {
    
    var name: String?
    var profileImageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case profileImageUrl = "avatar_url"
    }
}
