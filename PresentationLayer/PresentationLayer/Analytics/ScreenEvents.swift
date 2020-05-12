//
//  ScreenEvents.swift
//  PresentationLayer
//
//  Created by Victor C Tavernari on 08/05/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Analytics

enum ScreenEvents: ScreenEventType {
    case gitRepositoriesList
    case gitPullRequestList
    case gitPullRequestDetails

    var classValue: AnyClass? { nil }

    var name: String {
        switch self {
        case .gitRepositoriesList: return "git_repo_list"
        case .gitPullRequestList: return "git_pull_request_list"
        case .gitPullRequestDetails: return "git_pull_request_details"
        }
    }
}
