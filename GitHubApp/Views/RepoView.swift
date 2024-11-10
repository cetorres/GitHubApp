//
//  RepoView.swift
//  GitHubApp
//
//  Created by Carlos Eugenio Torres on 8/17/24.
//

import SwiftUI

struct RepoView: View {
    let repo: GitHubRepo
    @State private var viewModel = ViewModel()
    @Environment(UserState.self) var userState
    
    func loadData() async {
        await viewModel.getRepoContentAndReadme(userLogin: userState.userLogin.lowercased(), repo: repo.name)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(repo.name)
                Text(repo.description ?? "")
                Text("README.md")
                    .padding(.top, 16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Divider()
                    .padding(.bottom, 16)
                Text(LocalizedStringKey(viewModel.repoReadme ?? ""))
            }
            .padding()
        }
        .navigationBarTitle(repo.name, displayMode: .inline)
        .onAppear {
            Task {
                await loadData()
            }
        }
    }
}

#Preview {
    RepoView(repo: testRepo)
}
