//
//  PullRequestDetailViewModelTests.swift
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

class PullRequestDetailViewModelTests: XCTestCase {
    func testLoadDetail() {
        let scheduler = TestScheduler(initialClock: 0)
        let testPullRequest = scheduler.createObserver(GitPullRequest.self)
        let testStatus = scheduler.createObserver(ViewModelLoadStatus.self)
        let disposeBag = DisposeBag()

        var data = GitPullRequest()
        data.author = "author"
        data.id = 10

        let dataSource = MockGitPullRequestDataSource(result: Observable.just(data))
        let repository = GitPullRequestDataRepository(dataSource: dataSource)
        let useCase = DoGetPullRequestDetailUseCase(repository: repository)
        let viewModel = PullRequestDetailViewModel(useCase: useCase)

        viewModel.pullRequest.asDriver(onErrorJustReturn: GitPullRequest()).drive(testPullRequest).disposed(by: disposeBag)
        viewModel.status.asDriver(onErrorJustReturn: .fail("failed")).drive(testStatus).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, GitPullRequestDetailViewModelInputData(repo: GitRepository(), id: 1))])
            .bind(to: viewModel.load)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testPullRequest.events, [.next(1, data), .completed(1)])
        XCTAssertEqual(testStatus.events, [.next(1, .loading), .next(1, .loaded)])
    }
}
