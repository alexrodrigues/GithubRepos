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


extension UIViewController {
    func showErrorAlert(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
        }))
        present(alert, animated: true) {
        }
    }
}
