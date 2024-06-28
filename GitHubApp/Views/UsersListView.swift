//
//  ContentView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/25/24.
//

import SwiftUI

struct UsersListView: View {
    @State private var viewModel = ViewModel()
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var shouldShowUserAlert = false
    @State private var shouldShowUserSheet = false
    @State private var searchTerm = ""
    var filteredFollowers: [GitHubFollower] {
        guard !searchTerm.isEmpty else { return viewModel.followers ?? [] }
        return viewModel.followers != nil ? viewModel.followers!.filter { $0.login.localizedCaseInsensitiveContains(searchTerm) } : []
    }
    
    func loadData() async {
        await viewModel.getFollowers(userLogin: loginViewModel.userLogin.lowercased())
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
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
                    else if !viewModel.isLoading {
                        List(filteredFollowers, id: \.id) { user in
                            NavigationLink {
                                UserView(userLogin: user.login)
                                    .navigationBarTitle(user.login, displayMode: .inline)
                            } label: {
                                UserListItemView(user: user)
                            }
                        }
                        .searchable(text: $searchTerm)
                        .refreshable {
                            await loadData()
                        }
                        .overlay {
                            if filteredFollowers.isEmpty {
                                ContentUnavailableView.search(text: searchTerm)
                            }
                        }
                    }
                }
                .navigationTitle("Followers")
//                .toolbar {
//                    if viewModel.userLogin != "" {
//                        Button(viewModel.userLogin.lowercased()) {
//                            shouldShowUserSheet = true
//                        }
//                        .sheet(isPresented: $shouldShowUserSheet) {
//                            List {
//                                Button {
//                                    
//                                } label: {
//                                    Label("Show user profile", systemImage: "person")
//                                }
//                                
//                                Button {
//                                    shouldShowUserAlert = true
//                                } label: {
//                                    Label("Change user", systemImage: "rectangle.and.pencil.and.ellipsis")
//                                }
//                            }
//                            .padding(.top, 20)
//                            .listStyle(.plain)
//                            .presentationDetents([.height(110)])
//                            .presentationDragIndicator(.visible)
//                        }
//                    }
//                }
            }
            .task {
                await loadData()
            }
            .alert(isPresented: $viewModel.shouldShowErrorAlert) {
                return Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""))
            }
//            .alert("User Login", isPresented: $shouldShowUserAlert, actions: {
//                TextField("User login", text: $loginViewModel.userLogin)
//                    .autocorrectionDisabled()
//                    .textInputAutocapitalization(.never)
//                
//                Button("Save", action: {
//                    Task {
//                        loginViewModel.saveUserLogin()
//                        await viewModel.getFollowers(userLogin: viewModel.userLogin.lowercased())
//                    }
//                })
//                Button("Cancel", role: .cancel, action: {
//                    
//                })
//            }, message: {
//                Text("Enter a GitHub user to load their followers.")
//            })
            
            if viewModel.isLoading {
                ProgressView().controlSize(.large)
            }
        }
    }
}

#Preview {
    UsersListView()
        .environmentObject(LoginViewModel())
}
