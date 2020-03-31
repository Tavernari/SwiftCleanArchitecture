//
//  GithubUITestWithDataAssembly.swift
//  Presentation
//
//  Created by Victor C Tavernari on 18/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Swinject
import Domain
import DataSource

class MockGitRepoDataSource: GitRepoDataSource {
    func stats(repo: GitRepository, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        var gitRepoStatsModel = GitRepoStatsModel()
        gitRepoStatsModel.name = repo.name
        gitRepoStatsModel.closedIssues = 0
        gitRepoStatsModel.openedIssues = 0
        gitRepoStatsModel.mergedPullRequests = 0
        gitRepoStatsModel.proposedPullRequests = 0
        completion(.success(gitRepoStatsModel))
    }

    func list(term: String, completion: @escaping (Result<[GitRepository], Error>) -> Void) {
        var data1 = GitRepository()
        data1.name = "IOSArchitecture"
        data1.author = "Tavernari"
        data1.description = "Studying about Architecture for iOS Projects"
        data1.forkCount = 0
        data1.image = "https://picsum.photos/id/237/200/300"
        data1.starCount = 0
        data1.issuesCount = 0

        var data2 = GitRepository()
        data2.name = "ReSwiftMiddleware"
        data2.author = "Tavernari"
        data2.description = "This lib was created to help developers to handle the middlewares on ReSwift library"
        data2.forkCount = 1
        data2.image = "https://picsum.photos/id/400/200/300"
        data2.starCount = 4
        data2.issuesCount = 2

        completion(.success([data1, data2]))
    }
}

class MockPullRequestDataSource: GitPullRequestDataSource {
    func get(id: Int, fromRepo repo: GitRepository, completion: @escaping (Result<GitPullRequest, Error>) -> Void) {
        var pullRequest = GitPullRequest()
        pullRequest.additionsCount = 10
        pullRequest.author = "Luis"
        pullRequest.changedFilesCount = 100
        pullRequest.commentsCount = 4
        pullRequest.commitsCount = 30
        pullRequest.date = .init()
        pullRequest.deletionsCount = 20
        pullRequest.description = "Description of pull request"
        pullRequest.id = 1
        pullRequest.image = "https://picsum.photos/id/300/200/300"
        pullRequest.title = "Title of pull request"
        completion(.success(pullRequest))
    }

    func list(repo: GitRepository, completion: @escaping (Result<[GitPullRequest], Error>) -> Void) {
        var pullRequest = GitPullRequest()
         pullRequest.additionsCount = 10
         pullRequest.author = "Luis"
         pullRequest.changedFilesCount = 100
         pullRequest.commentsCount = 4
         pullRequest.commitsCount = 30
         pullRequest.date = .init()
         pullRequest.deletionsCount = 20
         pullRequest.description = "Description of pull request"
         pullRequest.id = 1
         pullRequest.image = "https://picsum.photos/id/300/200/300"
         pullRequest.title = "Title of pull request"
         completion(.success([pullRequest]))
    }
}

class GithubUITestWithDataAssembly: Assembly {
    func assemble(container: Container) {
        container.register(GitRepoDataSource.self) { _ in
            return MockGitRepoDataSource()
        }

        container.register(GitPullRequestDataSource.self) { _ in
            return MockPullRequestDataSource()
        }

        container.register(ConfigDataSource.self) { _ in
            return MemoryConfigDataSource(enable: true, multiplier: 4)
        }
    }
}
