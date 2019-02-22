//
//  UI+Accessibility.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 22/02/19.
//  Copyright © 2019 Alex Rodrigues. All rights reserved.
//

import UIKit

extension UIView {
    func receiveAccessibilityIdentifier(identifier: AccessibilityIdentifiers) {
        self.accessibilityIdentifier = identifier.rawValue
    }
}

extension UIBarButtonItem {
    func receiveAccessibilityIdentifier(identifier: AccessibilityIdentifiers) {
        self.accessibilityIdentifier = identifier.rawValue
    }
}
