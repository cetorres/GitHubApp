//
//  ReposListView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct ReposListView: View {
    @State private var viewModel = ViewModel()
    @Environment(UserState.self) var userState
    @State private var shouldShowUserAlert = false
    @State private var shouldShowUserSheet = false
    @State private var searchTerm = ""
    var filteredRepos: [GitHubRepo] {
        guard !searchTerm.isEmpty else { return viewModel.repos ?? [] }
        return viewModel.repos != nil ? viewModel.repos!.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) } : []
    }
    
    func loadData() async {
        await viewModel.getRepos(userLogin: userState.userLogin.lowercased())
    }
    
    var body: some View {
        NavigationStack {
            List(filteredRepos, id: \.id) { repo in
                NavigationLink {

                } label: {
                    RepoListItemView(repo: repo)
                }
            }
            .searchable(text: $searchTerm)
            .refreshable {
                await loadData()
            }
            .overlay {
                if !viewModel.isLoading && filteredRepos.isEmpty && searchTerm == "" {
                    ContentUnavailableView(label: {
                        VStack {
                            Image(systemName: "folder").font(.system(size: 50))
                            Text("No repos").font(.title2)
                        }
                    }, description: {
                        Text("Please try to refresh the data.")
                    }, actions: {
                        Button {
                            Task {
                                await loadData()
                            }
                        } label: {
                            Text("Refresh")
                        }
                        .buttonStyle(.borderedProminent)
                    })
                }
                else if !viewModel.isLoading && filteredRepos.isEmpty {
                    ContentUnavailableView.search(text: searchTerm)
                }
                
                if viewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
            }
            .navigationTitle("Repositories")
        }
        .onAppear {
            Task {
                await loadData()
            }
        }
        .alert(isPresented: $viewModel.shouldShowErrorAlert) {
            return Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""))
        }
    }
}

#Preview {
    ReposListView()
        .environment(UserState())
}
