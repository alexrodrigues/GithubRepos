//
//  GithubStarsApp.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 14/07/26.
//  Copyright © 2026 Alex Rodrigues. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@main
struct GithubStarsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(
                    store: Store(initialState: HomeFeature.State()) {
                        HomeFeature()
                    }
                )
            }
        }
    }
}
