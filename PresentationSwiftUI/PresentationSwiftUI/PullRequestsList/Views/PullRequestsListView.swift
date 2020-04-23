//
//  PullRequestsListView.swift
//  PresentationSwiftUI
//
//  Created by Lucas Silveira on 22/04/20.
//  Copyright © 2020 blu. All rights reserved.
//

import Domain
import SwiftUI

struct PullRequestsListView: View {
    @ObservedObject var viewModel: PullRequestsListViewModel
//    var repo: GHRepositoryViewModel

    var body: some View {
        VStack {
            if viewModel.pullRequests.isEmpty {
                CustomEmptyView(text: R.string.localizable.pullRequestsListMessageEmpty())
            } else {
                List {
                    ForEach(viewModel.pullRequests) { pr in
//                        NavigationLink(destination: PullRequestShowView(viewModel: .init(api: GitHubAPI(), repoName: self.viewModel.repoName, ownerName: self.viewModel.ownerName, number: pr.number), repo: self.repo)) {
                        CardView(title: pr.title, subtitle: pr.description, description: "created: \(pr.createdAt) | updated: \(pr.updatedAt)", avatarURL: pr.avatarURL,
                                 primary_icon: String(), primary_counter: String(),
                                 second_icon: String(), second_counter: String(),
                                 thirty_icon: String(), thirty_counter: String())
                            .frame(maxWidth: .infinity)
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.trailing, 10)
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                }
            }
//            }
        }
        .navigationBarTitle("PRs", displayMode: viewModel.pullRequests.count > 0 ? .automatic : .inline)
        .onAppear {
            self.viewModel.fetch()
        }
    }
}

struct PullRequestsListView_Previews: PreviewProvider {
    static var previews: some View {
        PullRequestsListView(viewModel: .init(useCase: UseCaseFacade.fetchPullRequestsUseCase(), gitRepository: GitRepository()))
    }
}
