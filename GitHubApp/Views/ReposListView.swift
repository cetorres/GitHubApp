//
//  ReposListView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/27/24.
//

import SwiftUI

struct ReposListView: View {
    @State private var viewModel = ViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var shouldShowUserAlert = false
    @State private var shouldShowUserSheet = false
    @State private var searchTerm = ""
    var filteredRepos: [GitHubRepo] {
        guard !searchTerm.isEmpty else { return viewModel.repos ?? [] }
        return viewModel.repos != nil ? viewModel.repos!.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) } : []
    }
    
    func loadData() async {
        await viewModel.getRepos(userLogin: loginViewModel.userLogin.lowercased())
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    if !viewModel.isLoading && filteredRepos.isEmpty && searchTerm == "" {
                        ContentUnavailableView(label: {
                            VStack {
                                Image(systemName: "person.2").font(.system(size: 50))
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
                    else if !viewModel.isLoading {
                        List(filteredRepos, id: \.id) { repo in
                            NavigationLink {
//                                UserView(userLogin: user.login)
//                                    .navigationBarTitle(user.login, displayMode: .inline)
                            } label: {
//                                UserListItemView(user: user)
                                Text(repo.name)
                            }
                        }
                        .searchable(text: $searchTerm)
                        .refreshable {
                            await loadData()
                        }
                        .overlay {
                            if filteredRepos.isEmpty {
                                ContentUnavailableView.search(text: searchTerm)
                            }
                        }
                    }
                }
                .navigationTitle("Repositories")
            }
            .task {
                await loadData()
            }
            .alert(isPresented: $viewModel.shouldShowErrorAlert) {
                return Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""))
            }
            
            if viewModel.isLoading {
                ProgressView().controlSize(.large)
            }
        }
    }
}

#Preview {
    ReposListView()
        .environmentObject(LoginViewModel())
}
