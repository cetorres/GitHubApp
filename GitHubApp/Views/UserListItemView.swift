//
//  UserListItem.swift
//  GitHubApp
//
//  Created by Carlos E. Torres on 6/26/24.
//

import SwiftUI

struct UserListItemView: View {
    let user: GitHubFollower?
    
    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
                    
            }
            .frame(width: 40, height: 40)
            
            VStack(alignment: .leading) {
                Text(user?.login ?? "")
                    .font(.headline)
            }
        }
    }
}

#Preview {
    UserListItemView(user: testFollower)
}
