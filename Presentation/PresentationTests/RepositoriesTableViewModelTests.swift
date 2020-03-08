//
//  RepositoriesTableViewModelTests.swift
//  PresentationTests
//
//  Created by Victor C Tavernari on 07/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import XCTest
import Domain
import DataSource
import RxSwift
import RxTest
import RxBlocking
@testable import Presentation

class MockGitRepoDataSource: GitRepoDataSource {

    private let result: Observable<[GitRepository]>
    init(result: Observable<[GitRepository]>){
        self.result = result
    }

    func list(term: String) -> Observable<[GitRepository]> {
        return result
    }
}

class RepositoriesTableViewModelTests: XCTestCase {
    func testListRepository() {
        let scheduler = TestScheduler(initialClock: 0)
        let testRepositories = scheduler.createObserver([GitRepository].self)
        let testStatus = scheduler.createObserver(ViewModelLoadStatus.self)
        let disposeBag = DisposeBag()

        let data = GitRepository()
        let datasource = MockGitRepoDataSource(result: Observable.just([data, data]))
        let repository = DataSource.GitRepoRepository(dataSource: datasource)
        let useCase = DoListGitRepositoryUseCase(repository: repository)
        let viewModel = RepositoriesTableViewModel(listGitRepositoryUseCase: useCase)

        viewModel.repositories.asDriver(onErrorJustReturn: []).drive(testRepositories).disposed(by: disposeBag)
        viewModel.status.asDriver(onErrorJustReturn: .fail("failed")).drive(testStatus).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, "Javascript")])
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testRepositories.events, [.next(1, [data, data]), .completed(1)])
        XCTAssertEqual(testStatus.events, [.next(1, .loading), .next(1, .loaded)])
    }

    func testSelectRepository() {
        let scheduler = TestScheduler(initialClock: 0)
        let testRoute = scheduler.createObserver(GitRepositoriesListRoute.self)
        let testStatus = scheduler.createObserver(ViewModelLoadStatus.self)
        let disposeBag = DisposeBag()

        var data1 = GitRepository()
        data1.name = "repository1DataName"
        data1.author = "repository1DataAuthor"

        var data2 = GitRepository()
        data2.name = "repository2DataName"
        data2.author = "repository2DataAuthor"

        let datasource = MockGitRepoDataSource(result: Observable.just([data1, data2]))
        let repository = DataSource.GitRepoRepository(dataSource: datasource)
        let useCase = DoListGitRepositoryUseCase(repository: repository)
        let viewModel = RepositoriesTableViewModel(listGitRepositoryUseCase: useCase)

        viewModel.route.asDriver(onErrorJustReturn: .none).drive(testRoute).disposed(by: disposeBag)
        viewModel.status.asDriver(onErrorJustReturn: .fail("failed")).drive(testStatus).disposed(by: disposeBag)

        scheduler
            .createColdObservable([.next(1, "Javascript")])
            .bind(to: viewModel.search)
            .disposed(by: disposeBag)

        let selectIndex = 1
        scheduler
            .createColdObservable([.next(2, selectIndex)])
            .bind(to: viewModel.select)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(testStatus.events, [.next(1, .loading), .next(1, .loaded)])
        XCTAssertEqual(testRoute.events, [.next(2, .showPullRequests(repo: data2))])
    }
}
