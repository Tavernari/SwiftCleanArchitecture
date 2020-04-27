//
//  GithubRepositoryDataReponseFake.swift
//  PresentationUITests
//
//  Created by Victor C Tavernari on 05/04/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import DataLayer
import Foundation

class GithubRepositoryDataReponseFake {
    static func repositoriesData() -> Data {
        var githubResponseData = GitReposResponseData()

        var owner = GitRepositoryOwnerData()
        owner.login = "Tavernari"
        owner.avatar_url = "https://picsum.photos/id/15/200/300"

        var githubRepositoryData1 = GitbRepositoryData()
        githubRepositoryData1.name = "IOSArchitecture"
        githubRepositoryData1.owner = owner
        githubRepositoryData1.description = "Studying about Architecture for iOS Projects"
        githubResponseData.items.append(githubRepositoryData1)

        var githubRepositoryData2 = GitbRepositoryData()
        githubRepositoryData2.name = "ReSwiftMiddleware"
        githubRepositoryData2.owner = owner
        githubRepositoryData2.forks_count = 1
        githubRepositoryData2.stargazers_count = 4
        githubRepositoryData2.open_issues_count = 2
        githubRepositoryData2.description = "This lib was created to help developers to handle the middlewares on ReSwift library"
        githubResponseData.items.append(githubRepositoryData2)

        let githubResponseJsonData = try? JSONEncoder().encode(githubResponseData)

        return githubResponseJsonData ?? Data()
    }

    static func listOfPullsData() -> Data {
        var user = GitPullRequestUser()
        user.avatar_url = "https://picsum.photos/id/5/200/300"
        user.login = "Luis"

        var response = GitPullRequestData()
        response.title = "Title of pull request"
        response.body = "Description of pull request"
        response.created_at = "2020-04-05T03:31:27Z"
        response.user = user
        response.number = 1

        guard let responseJsonData = try? JSONEncoder().encode([response]) else {
            fatalError()
        }

        return responseJsonData
    }

    static func pullDetailData() -> Data {
        var user = GitPullRequestUser()
        user.avatar_url = "https://picsum.photos/id/5/200/300"
        user.login = "Luis"

        var response = GitPullRequestDetailData()
        response.additions = 10
        response.body = "Description of pull request"
        response.changed_files = 100
        response.comments = 4
        response.commits = 30
        response.created_at = "2020-04-05T03:31:27Z"
        response.deletions = 20
        response.number = 1
        response.title = "Title of pull request"
        response.user = user

        guard let responseJsonData = try? JSONEncoder().encode(response) else {
            fatalError()
        }
        return responseJsonData
    }

    static func errorData(message: String) -> Data {
        let error = GithubAPIError(message: message)

        guard let responseJsonData = try? JSONEncoder().encode(error) else {
            fatalError()
        }

        return responseJsonData
    }
}
