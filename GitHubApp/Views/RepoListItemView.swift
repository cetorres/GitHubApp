//
//  RepoListItemView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/28/24.
//

import SwiftUI

struct RepoListItemView: View {
    let repo: GitHubRepo?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(repo?.name ?? "")
                    .font(.headline)
                if let description = repo?.description {
                    Text(description)
                        .font(.subheadline)
                }
                HStack (spacing: 20) {
                    HStack {
                        Image(systemName: "star")
                            .font(.caption)
                            .foregroundColor(.accentColor)
                        Text("\(repo?.stargazersCount ?? 0)")
                            .font(.subheadline)
                    }
                    if let language = repo?.language {
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundColor(.accentColor)
                            Text(language)
                                .font(.subheadline)
                        }
                    }
                    if let createdAt = repo?.createdAt {
                        HStack {
                            Image(systemName: "clock")
                                .font(.caption)
                                .foregroundColor(.accentColor)
                            Text(createdAt.formatted(date: .abbreviated, time: .omitted))
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    RepoListItemView(repo: testRepo)
}
