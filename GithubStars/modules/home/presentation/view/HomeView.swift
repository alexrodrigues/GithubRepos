//
//  HomeView.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 14/07/26.
//  Copyright © 2026 Alex Rodrigues. All rights reserved.
//

import SwiftUI

struct HomeView: View {

    private let viewModel = HomeViewModel()

    @State private var repos: [RepositoryResponse] = []
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var showError = false

    var body: some View {
        Group {
            if isLoading && repos.isEmpty {
                ProgressView()
            } else {
                List(repos.indices, id: \.self) { index in
                    let repo = repos[index]
                    DefaultCell(
                        ownerName: repo.ownerName,
                        repoName: repo.name,
                        totalStars: repo.totalStars,
                        ownerImageURL: repo.ownerImage
                    )
                }
            }
        }
        .navigationTitle("Github's repos")
        .task {
            await loadRepos()
        }
        .refreshable {
            await loadRepos()
        }
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "Something went wrong")
        }
    }

    private func loadRepos() async {
        if repos.isEmpty {
            isLoading = true
        }
        do {
            repos = try await viewModel.fetch()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        isLoading = false
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
