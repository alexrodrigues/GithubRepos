//
//  HomeView.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 14/07/26.
//  Copyright © 2026 Alex Rodrigues. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        Group {
            if store.isLoading && store.repos.isEmpty {
                ProgressView()
            } else {
                List(store.repos.indices, id: \.self) { index in
                    let repo = store.repos[index]
                    DefaultCell(
                        ownerName: repo.ownerName,
                        repoName: repo.name,
                        totalStars: repo.totalStars,
                        ownerImageURL: repo.ownerImage
                    )
                }.onTapGesture {
                    store.send(.onClick)
                }
            }
        }
        .navigationTitle("Github's repos")
        .task {
            store.send(.onAppear)
        }
        .refreshable {
            await store.send(.refresh).finish()
        }
        .alert(
            "Notice",
            isPresented: Binding(
                get: { store.errorMessage != nil },
                set: { isPresented in
                    if !isPresented {
                        store.send(.dismissError)
                    }
                }
            )
        ) {
            Button("OK", role: .cancel) {
                store.send(.dismissError)
            }
        } message: {
            Text(store.errorMessage ?? "Something went wrong")
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(
            store: Store(initialState: HomeFeature.State()) {
                HomeFeature()
            } withDependencies: {
                $0.githubClient = .previewValue
            }
        )
    }
}
