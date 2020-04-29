//
//  RepositoriesListItemView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DomainLayer
import SwiftUI

struct GitRepositoriesListItemView: View {
    var repo: GitRepositoryUIModel

    var body: some View {
        ZStack(alignment: .topLeading) {
            CardView(title: repo.name, subtitle: repo.login, description: repo.description, avatarURL: repo.avatarURL,
                     primary_icon: "info.circle", primary_counter: repo.issues.description,
                     second_icon: "star.fill", second_counter: repo.stargazers.description,
                     thirty_icon: "tuningfork", thirty_counter: repo.forks.description)

            if self.repo.showStats {
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                    Text(Int(self.repo.stats).description).font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .padding(.top, 100)
                .padding(.leading, 22)
            }
        }
    }
}

struct RepositoriesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        GitRepositoriesListItemView(repo: GitRepositoryUIModel(ghRepository: GitRepositoryModel()))
    }
}
