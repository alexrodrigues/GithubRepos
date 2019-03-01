//
//  Extensions.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 28/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import UIKit


extension URL {
    init(endpoint: Endpoints) {
        self = URL(string: endpoint.rawValue)!
    }
}

struct MyError: Error {
    let msg: String
    
}
extension MyError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(msg, comment: "")
    }
}


