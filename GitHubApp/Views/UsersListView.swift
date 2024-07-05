//
//  ContentView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/25/24.
//

import SwiftUI

struct UsersListView: View {
    @Environment(UserState.self) var userState
    
    @Binding var path: NavigationPath
    @Binding var scrollToTop: Bool
    
    @State private var viewModel = ViewModel()
    @State private var shouldShowUserAlert = false
    @State private var shouldShowUserSheet = false
    @State private var searchTerm = ""
    
    var filteredFollowers: [GitHubFollower] {
        guard !searchTerm.isEmpty else { return viewModel.followers ?? [] }
        return viewModel.followers != nil ? viewModel.followers!.filter { $0.login.localizedCaseInsensitiveContains(searchTerm) } : []
    }
    
    func loadData() async {
        await viewModel.getFollowers(userLogin: userState.userLogin.lowercased())
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollViewReader { proxy in
                List(filteredFollowers, id: \.id) { user in
                    NavigationLink(value: user) {
                        UserListItemView(user: user)
                    }
                    .id(user.id)
                }
                .navigationDestination(for: GitHubFollower.self, destination: { user in
                    UserView(userLogin: user.login)
                        .navigationBarTitle(user.login, displayMode: .inline)
                })
                .onChange(of: scrollToTop) { _, newState in
                    if newState {
                        withAnimation {
                            proxy.scrollTo(filteredFollowers.first?.id, anchor: .top)
                        }
                        scrollToTop = false
                    }
                }
            }
            .searchable(text: $searchTerm)
            .refreshable {
                await loadData()
            }
            .overlay {
                if !viewModel.isLoading && filteredFollowers.isEmpty && searchTerm == "" {
                    ContentUnavailableView(label: {
                        VStack {
                            Image(systemName: "person.2").font(.system(size: 50))
                            Text("No followers").font(.title2)
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
                else if !viewModel.isLoading && filteredFollowers.isEmpty {
                    ContentUnavailableView.search(text: searchTerm)
                }
                
                if viewModel.isLoading {
                    ProgressView().controlSize(.large)
                }
            }
            .navigationTitle("Followers")
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
    UsersListView(path: .constant(NavigationPath()), scrollToTop: .constant(false))
        .environment(UserState())
}
