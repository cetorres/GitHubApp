//
//  UserView.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/26/24.
//

import SwiftUI

struct UserView: View {
    let userLogin: String
    @State private var viewModel = ViewModel()

    var body: some View {
        List {
            Section {
                VStack {
                    AsyncImage(url: URL(string: viewModel.user?.avatarUrl ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    } placeholder: {
                        Circle()
                            .foregroundColor(.secondary)
                    }
                        .frame(width: 120, height: 120)

                    Text(viewModel.user?.login ?? "")
                        .bold()
                        .font(.title3)
                }
                .frame(maxWidth: .infinity, alignment: .center)

                HStack(spacing: 60) {
                    VStack {
                        Text("\(viewModel.user?.followers ?? 0)").bold()
                        Text("Followers").font(.caption)
                    }
                    VStack {
                        Text("\(viewModel.user?.following ?? 0)").bold()
                        Text("Following").font(.caption)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .listRowSeparator(.hidden)

            if let bio = viewModel.user?.bio {
                Section("Bio") {
                    Text(bio.trimmingCharacters(in: .whitespacesAndNewlines))
                }
            }

            Section("More info") {
                if let name = viewModel.user?.name {
                    HStack {
                        Text("Name").bold()
                        Spacer()
                        Text(name)
                    }
                }
                if let email = viewModel.user?.email {
                    HStack {
                        Text("E-mail").bold()
                        Spacer()
                        Text(email)
                    }
                }
                if let company = viewModel.user?.company {
                    HStack {
                        Text("Company").bold()
                        Spacer()
                        Text(company)
                    }
                }
                if let location = viewModel.user?.location {
                    HStack {
                        Text("Location").bold()
                        Spacer()
                        Text(location)
                    }
                }
                if let twitterUsername = viewModel.user?.twitterUsername {
                    HStack {
                        Text("Twitter (X)").bold()
                        Spacer()
                        Link(twitterUsername.lowercased(), destination: URL(string: "https://twitter.com/\(twitterUsername.lowercased())")!)
                    }
                }
                if let blog = viewModel.user?.blog {
                    if blog != "" {
                        HStack {
                            Text("Blog").bold()
                            Spacer()
                            Link(blog.lowercased(), destination: URL(string: blog.lowercased().contains("http") ? blog.lowercased() : "http://\(blog.lowercased())" )!)
                        }
                    }
                }
                if let htmlUrl = viewModel.user?.htmlUrl {
                    HStack {
                        Text("Profile").bold()
                        Spacer()
                        Link(htmlUrl.lowercased(), destination: URL(string: htmlUrl.lowercased())!)
                    }
                }
            }
        }
        .padding(.top, -20)
        .task {
            await viewModel.getUser(userLogin: userLogin)
        }
        .alert(isPresented: $viewModel.shouldShowErrorAlert) {
            return Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? ""))
        }
    }
}

#Preview {
    UserView(userLogin: "cetorres")
}
