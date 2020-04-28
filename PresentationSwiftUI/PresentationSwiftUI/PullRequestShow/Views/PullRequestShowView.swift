//
//  PullRequestShowView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 23/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import DomainLayer
import SwiftUI

struct PullRequestShowView: View {
    @ObservedObject var viewModel: GitPullRequestDetailViewModel
    var repo: GitRepositoryUIModel

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

            VStack(alignment: .leading, spacing: 15) {
                Text(viewModel.pullRequest!.title).foregroundColor(.black).font(.title)
                Text(viewModel.pullRequest!.description)
                Text("comments: \(viewModel.pullRequest!.comments)")
                Text("additions: \(viewModel.pullRequest!.additions)")
                Text("commits: \(viewModel.pullRequest!.commits)")
                Text("deletions: \(viewModel.pullRequest!.deletions)")
                Text("data: \(viewModel.pullRequest!.createdAt)")
            }
            .padding(.top, 20)
            .padding(.horizontal, 22)
            .font(.caption)
            .foregroundColor(.gray)

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
            .navigationBarTitle("\(viewModel.pullRequestName!.prefix(10).description) (\(viewModel.commits.count.description))", displayMode: .inline)
        }
    }
}

struct PullRequestShowView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestShowView(viewModel: .init(fetchPullRequestDetailUseCase: UseCaseFacade.fetchPullRequestDetailUseCase(), fetchPullRequestCommitsUseCase: UseCaseFacade.fetchPullRequestCommitsUseCase(), repo: GitRepositoryModel(), pullRequestId: 12, pullRequestName: "Some name..", repoName: "foo", ownerName: "bar"), repo: GitRepositoryUIModel(ghRepository: GitRepositoryModel()))
    }
}
