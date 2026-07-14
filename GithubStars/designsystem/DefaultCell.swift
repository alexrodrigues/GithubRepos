//
//  DefaultCell.swift
//  GithubStars
//
//  Created by Alex Rodrigues on 14/07/26.
//  Copyright © 2026 Alex Rodrigues. All rights reserved.
//

import SwiftUI

struct DefaultCell: View {

    let ownerName: String
    let repoName: String
    let totalStars: Int
    let ownerImageURL: String

    var body: some View {
        HStack {
            
            DefaultCellProfileImage(ownerImageURL: ownerImageURL)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(repoName)
                    Text(ownerName)
                }
                Spacer()
                Text("\(totalStars) ★")
                Image(systemName: "chevron.right")
                    .foregroundStyle(.secondary)
            }

        }
        .padding()
    }
}

struct DefaultCellProfileImage: View {
    
    let ownerImageURL: String
    
    var body: some View {
        AsyncImage(url: URL(string: ownerImageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "person.crop.circle.fill") // fallback
                    .resizable()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 48, height: 48)
        .clipShape(Circle())
    }
}

#Preview {
    DefaultCell(
        ownerName: "octocat",
        repoName: "Hello-World",
        totalStars: 42,
        ownerImageURL: "https://avatars.githubusercontent.com/u/1680273?v=4"
    )
}
