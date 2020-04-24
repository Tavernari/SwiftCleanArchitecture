//
//  PullRequestShowView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import SwiftUI

struct PullRequestShowView: View {
    @ObservedObject var viewModel: PullRequestShowViewModel
    var repo: GHRepositoryViewModel

    var body: some View {
        VStack(alignment: .leading) {
            if self.repo.showStats {
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                    Text(Int(repo.stats).description).font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .padding(.top, 20)
                .padding(.leading, 22)
            }
            List {
                ForEach(viewModel.commits) { commit in
                    VStack(alignment: .leading, spacing: 10) {
                        Text(commit.sha)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(commit.author)
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(commit.message)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding(5)

                    if commit.sha != self.viewModel.commits.last!.sha {
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 0.5)
                            .foregroundColor(Color.gray)
                    }
                }
            }
            .padding(.top, 20)
            .navigationBarTitle("\(viewModel.prName!.prefix(10).description) (\(viewModel.commits.count.description))", displayMode: .inline)
        }
    }
}

struct PullRequestShowView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestShowView(viewModel: .init(useCase: UseCaseFacade.fetchPullRequestCommitsUseCase(), prName: "Some name..", repoName: "foo", ownerName: "bar"), repo: GHRepositoryViewModel(ghRepository: GitRepository()))
    }
}
