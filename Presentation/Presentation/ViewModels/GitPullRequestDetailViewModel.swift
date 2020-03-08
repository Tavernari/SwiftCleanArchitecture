//
//  GitPullRequestDetailViewModel.swift
//  Presentation
//
//  Created by Victor C Tavernari on 08/03/20.
//  Copyright © 2020 Taverna Apps. All rights reserved.
//

import Domain
import RxSwift

struct GitPullRequestDetailViewModelInputData {
    public var repo: GitRepository!
    public var id: Int!
}
protocol GitPullRequestDetailViewModelInput {
    var load: PublishSubject<GitPullRequestDetailViewModelInputData> { get }
}

protocol GitPullRequestDetailViewModelOutput {
    var pullRequest: Observable<GitPullRequest> { get }
    var status: Observable<ViewModelLoadStatus> { get }
}

protocol GitPullRequestDetailViewModel: GitPullRequestDetailViewModelInput, GitPullRequestDetailViewModelOutput {}

class PullRequestDetailViewModel: GitPullRequestDetailViewModel {

    lazy var load: PublishSubject<GitPullRequestDetailViewModelInputData> = {
        let load = PublishSubject<GitPullRequestDetailViewModelInputData>()
        load
            .do(onNext: { _ in self.statusSubject.onNext(.loading) })
            .subscribe(onNext: self.load)
            .disposed(by: self.disposeBag)
        return load
    }()

    private let pullRequestSubject = PublishSubject<GitPullRequest>()
    var pullRequest: Observable<GitPullRequest> { pullRequestSubject }

    private let statusSubject = PublishSubject<ViewModelLoadStatus>()
    var status: Observable<ViewModelLoadStatus> { statusSubject }

    private let useCase: GetPullRequestDetailUseCase
    private let disposeBag = DisposeBag()
    init(useCase: GetPullRequestDetailUseCase) {
        self.useCase = useCase
    }

    private func load(data: GitPullRequestDetailViewModelInputData) {
        self.useCase.execute(id: data.id, fromRepo: data.repo) { (result) in
            switch result {
            case .success(let data):
                self.statusSubject.onNext(.loaded)
                self.pullRequestSubject.onNext(data)
            case .failure(let error):
                self.statusSubject.onNext(.fail(error.localizedDescription))
            }
        }
    }

}
