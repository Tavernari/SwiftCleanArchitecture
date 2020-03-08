//
//  GitPullRequestsViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import Domain
import DataSource
import RxSwift
import RxTest
import RxBlocking
@testable import Presentation

class GitPullRequestsViewModelTests: XCTestCase {
    func testListPullRequests() {
        let scheduler = TestScheduler(initialClock: 0)
        let testPullRequests = scheduler.createObserver([GitPullRequest].self)
        let testStatus = scheduler.createObserver(ViewModelLoadStatus.self)
        let disposeBag = DisposeBag()

        let data = GitPullRequest()
        let dataSource = MockGitPullRequestDataSource(result: Observable.just([data]))
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        let viewModel = GitListPullRequestViewModel(listPullRequestsUseCase: useCase)

        viewModel.pullRequests.asDriver(onErrorJustReturn: []).drive(testPullRequests).disposed(by: disposeBag)
        viewModel.status.asDriver(onErrorJustReturn: .fail("failed")).drive(testStatus).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, GitRepository())])
            .bind(to: viewModel.load)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testPullRequests.events, [.next(1, [data])])
        XCTAssertEqual(testStatus.events, [.next(1, .loading), .next(1, .loaded)])
    }

    func testSelectPullRequest() {

        let scheduler = TestScheduler(initialClock: 0)
        let testRoute = scheduler.createObserver(GitPullRequestViewModelRoute.self)
        let testStatus = scheduler.createObserver(ViewModelLoadStatus.self)
        let disposeBag = DisposeBag()

        var repo = GitRepository()

        var data1 = GitPullRequest()
        data1.author = "data1"
        data1.id = 400
        var data2 = GitPullRequest()
        data2.author = "data2"
        data2.id = 500

        let dataSource = MockGitPullRequestDataSource(result: Observable.just([data1, data2]))
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoListPullRequestsUseCase(repository: repository)
        let viewModel = GitListPullRequestViewModel(listPullRequestsUseCase: useCase)

        viewModel.route.asDriver(onErrorJustReturn: .none).drive(testRoute).disposed(by: disposeBag)
        viewModel.status.asDriver(onErrorJustReturn: .fail("failed")).drive(testStatus).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, repo)])
            .bind(to: viewModel.load)
            .disposed(by: disposeBag)

        let selectIndex = 0
        scheduler
           .createColdObservable([.next(2, selectIndex)])
           .bind(to: viewModel.select)
           .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testRoute.events, [.next(2, .showPullRequestDetail(id: data1.id, repo: repo))])
        XCTAssertEqual(testStatus.events, [.next(1, .loading), .next(1, .loaded)])

    }
}
