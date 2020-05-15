// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import Foundation
import DomainLayer
import DataLayer
@testable import PresentationLayer


// MARK: - ConfigRepositoryProtocol
open class ConfigRepositoryProtocolMock: ConfigRepositoryProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func gitRepoReliabilityMultiplier(completion: @escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) {
        addInvocation(.m_gitRepoReliabilityMultiplier__completion_completion(Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_gitRepoReliabilityMultiplier__completion_completion(Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>.value(`completion`))) as? (@escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) -> Void
		perform?(`completion`)
    }


    fileprivate enum MethodType {
        case m_gitRepoReliabilityMultiplier__completion_completion(Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_gitRepoReliabilityMultiplier__completion_completion(let lhsCompletion), .m_gitRepoReliabilityMultiplier__completion_completion(let rhsCompletion)):
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_gitRepoReliabilityMultiplier__completion_completion(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func gitRepoReliabilityMultiplier(completion: Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>) -> Verify { return Verify(method: .m_gitRepoReliabilityMultiplier__completion_completion(`completion`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func gitRepoReliabilityMultiplier(completion: Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>, perform: @escaping (@escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_gitRepoReliabilityMultiplier__completion_completion(`completion`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - FetchGitRepositoriesInterfaceAdapter
open class FetchGitRepositoriesInterfaceAdapterMock: FetchGitRepositoriesInterfaceAdapter, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func doing() {
        addInvocation(.m_doing)
		let perform = methodPerformValue(.m_doing) as? () -> Void
		perform?()
    }

    open func done(data: [GitRepositoryModel]) {
        addInvocation(.m_done__data_data(Parameter<[GitRepositoryModel]>.value(`data`)))
		let perform = methodPerformValue(.m_done__data_data(Parameter<[GitRepositoryModel]>.value(`data`))) as? ([GitRepositoryModel]) -> Void
		perform?(`data`)
    }

    open func failure(withError error: FetchGitRepositoriesError) {
        addInvocation(.m_failure__withError_error(Parameter<FetchGitRepositoriesError>.value(`error`)))
		let perform = methodPerformValue(.m_failure__withError_error(Parameter<FetchGitRepositoriesError>.value(`error`))) as? (FetchGitRepositoriesError) -> Void
		perform?(`error`)
    }


    fileprivate enum MethodType {
        case m_doing
        case m_done__data_data(Parameter<[GitRepositoryModel]>)
        case m_failure__withError_error(Parameter<FetchGitRepositoriesError>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_doing, .m_doing):
                return true 
            case (.m_done__data_data(let lhsData), .m_done__data_data(let rhsData)):
                guard Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher) else { return false } 
                return true 
            case (.m_failure__withError_error(let lhsError), .m_failure__withError_error(let rhsError)):
                guard Parameter.compare(lhs: lhsError, rhs: rhsError, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_doing: return 0
            case let .m_done__data_data(p0): return p0.intValue
            case let .m_failure__withError_error(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func doing() -> Verify { return Verify(method: .m_doing)}
        public static func done(data: Parameter<[GitRepositoryModel]>) -> Verify { return Verify(method: .m_done__data_data(`data`))}
        public static func failure(withError error: Parameter<FetchGitRepositoriesError>) -> Verify { return Verify(method: .m_failure__withError_error(`error`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func doing(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_doing, performs: perform)
        }
        public static func done(data: Parameter<[GitRepositoryModel]>, perform: @escaping ([GitRepositoryModel]) -> Void) -> Perform {
            return Perform(method: .m_done__data_data(`data`), performs: perform)
        }
        public static func failure(withError error: Parameter<FetchGitRepositoriesError>, perform: @escaping (FetchGitRepositoriesError) -> Void) -> Perform {
            return Perform(method: .m_failure__withError_error(`error`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - FetchGitRepositoriesUseCaseProtocol
open class FetchGitRepositoriesUseCaseProtocolMock: FetchGitRepositoriesUseCaseProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var delegateInterfaceAdapter: FetchGitRepositoriesInterfaceAdapter? {
		get {	invocations.append(.p_delegateInterfaceAdapter_get); return __p_delegateInterfaceAdapter ?? optionalGivenGetterValue(.p_delegateInterfaceAdapter_get, "FetchGitRepositoriesUseCaseProtocolMock - stub value for delegateInterfaceAdapter was not defined") }
		set {	invocations.append(.p_delegateInterfaceAdapter_set(.value(newValue))); __p_delegateInterfaceAdapter = newValue }
	}
	private var __p_delegateInterfaceAdapter: (FetchGitRepositoriesInterfaceAdapter)?





    open func execute(term: String) {
        addInvocation(.m_execute__term_term(Parameter<String>.value(`term`)))
		let perform = methodPerformValue(.m_execute__term_term(Parameter<String>.value(`term`))) as? (String) -> Void
		perform?(`term`)
    }


    fileprivate enum MethodType {
        case m_execute__term_term(Parameter<String>)
        case p_delegateInterfaceAdapter_get
		case p_delegateInterfaceAdapter_set(Parameter<FetchGitRepositoriesInterfaceAdapter?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_execute__term_term(let lhsTerm), .m_execute__term_term(let rhsTerm)):
                guard Parameter.compare(lhs: lhsTerm, rhs: rhsTerm, with: matcher) else { return false } 
                return true 
            case (.p_delegateInterfaceAdapter_get,.p_delegateInterfaceAdapter_get): return true
			case (.p_delegateInterfaceAdapter_set(let left),.p_delegateInterfaceAdapter_set(let right)): return Parameter<FetchGitRepositoriesInterfaceAdapter?>.compare(lhs: left, rhs: right, with: matcher)
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__term_term(p0): return p0.intValue
            case .p_delegateInterfaceAdapter_get: return 0
			case .p_delegateInterfaceAdapter_set(let newValue): return newValue.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func delegateInterfaceAdapter(getter defaultValue: FetchGitRepositoriesInterfaceAdapter?...) -> PropertyStub {
            return Given(method: .p_delegateInterfaceAdapter_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(term: Parameter<String>) -> Verify { return Verify(method: .m_execute__term_term(`term`))}
        public static var delegateInterfaceAdapter: Verify { return Verify(method: .p_delegateInterfaceAdapter_get) }
		public static func delegateInterfaceAdapter(set newValue: Parameter<FetchGitRepositoriesInterfaceAdapter?>) -> Verify { return Verify(method: .p_delegateInterfaceAdapter_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(term: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_execute__term_term(`term`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - GitRepoDataSourceProtocol
open class GitRepoDataSourceProtocolMock: GitRepoDataSourceProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func list(term: String, completion: @escaping (Result<GitReposResponseDTO, Error>) -> Void) {
        addInvocation(.m_list__term_termcompletion_completion(Parameter<String>.value(`term`), Parameter<(Result<GitReposResponseDTO, Error>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_list__term_termcompletion_completion(Parameter<String>.value(`term`), Parameter<(Result<GitReposResponseDTO, Error>) -> Void>.value(`completion`))) as? (String, @escaping (Result<GitReposResponseDTO, Error>) -> Void) -> Void
		perform?(`term`, `completion`)
    }

    open func stats(repo: GitRepositoryModel, completion: @escaping (Result<GitRepoStatsModel, Error>) -> Void) {
        addInvocation(.m_stats__repo_repocompletion_completion(Parameter<GitRepositoryModel>.value(`repo`), Parameter<(Result<GitRepoStatsModel, Error>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_stats__repo_repocompletion_completion(Parameter<GitRepositoryModel>.value(`repo`), Parameter<(Result<GitRepoStatsModel, Error>) -> Void>.value(`completion`))) as? (GitRepositoryModel, @escaping (Result<GitRepoStatsModel, Error>) -> Void) -> Void
		perform?(`repo`, `completion`)
    }


    fileprivate enum MethodType {
        case m_list__term_termcompletion_completion(Parameter<String>, Parameter<(Result<GitReposResponseDTO, Error>) -> Void>)
        case m_stats__repo_repocompletion_completion(Parameter<GitRepositoryModel>, Parameter<(Result<GitRepoStatsModel, Error>) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_list__term_termcompletion_completion(let lhsTerm, let lhsCompletion), .m_list__term_termcompletion_completion(let rhsTerm, let rhsCompletion)):
                guard Parameter.compare(lhs: lhsTerm, rhs: rhsTerm, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            case (.m_stats__repo_repocompletion_completion(let lhsRepo, let lhsCompletion), .m_stats__repo_repocompletion_completion(let rhsRepo, let rhsCompletion)):
                guard Parameter.compare(lhs: lhsRepo, rhs: rhsRepo, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_list__term_termcompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case let .m_stats__repo_repocompletion_completion(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func list(term: Parameter<String>, completion: Parameter<(Result<GitReposResponseDTO, Error>) -> Void>) -> Verify { return Verify(method: .m_list__term_termcompletion_completion(`term`, `completion`))}
        public static func stats(repo: Parameter<GitRepositoryModel>, completion: Parameter<(Result<GitRepoStatsModel, Error>) -> Void>) -> Verify { return Verify(method: .m_stats__repo_repocompletion_completion(`repo`, `completion`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func list(term: Parameter<String>, completion: Parameter<(Result<GitReposResponseDTO, Error>) -> Void>, perform: @escaping (String, @escaping (Result<GitReposResponseDTO, Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_list__term_termcompletion_completion(`term`, `completion`), performs: perform)
        }
        public static func stats(repo: Parameter<GitRepositoryModel>, completion: Parameter<(Result<GitRepoStatsModel, Error>) -> Void>, perform: @escaping (GitRepositoryModel, @escaping (Result<GitRepoStatsModel, Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_stats__repo_repocompletion_completion(`repo`, `completion`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - GitRepoRepositoryProtocol
open class GitRepoRepositoryProtocolMock: GitRepoRepositoryProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func list(term: String, completion: @escaping (Result<[GitRepositoryModel], Error>) -> Void) {
        addInvocation(.m_list__term_termcompletion_completion(Parameter<String>.value(`term`), Parameter<(Result<[GitRepositoryModel], Error>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_list__term_termcompletion_completion(Parameter<String>.value(`term`), Parameter<(Result<[GitRepositoryModel], Error>) -> Void>.value(`completion`))) as? (String, @escaping (Result<[GitRepositoryModel], Error>) -> Void) -> Void
		perform?(`term`, `completion`)
    }

    open func getRepoReliabilityMultiplier(completion: @escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) {
        addInvocation(.m_getRepoReliabilityMultiplier__completion_completion(Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_getRepoReliabilityMultiplier__completion_completion(Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>.value(`completion`))) as? (@escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) -> Void
		perform?(`completion`)
    }


    fileprivate enum MethodType {
        case m_list__term_termcompletion_completion(Parameter<String>, Parameter<(Result<[GitRepositoryModel], Error>) -> Void>)
        case m_getRepoReliabilityMultiplier__completion_completion(Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_list__term_termcompletion_completion(let lhsTerm, let lhsCompletion), .m_list__term_termcompletion_completion(let rhsTerm, let rhsCompletion)):
                guard Parameter.compare(lhs: lhsTerm, rhs: rhsTerm, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            case (.m_getRepoReliabilityMultiplier__completion_completion(let lhsCompletion), .m_getRepoReliabilityMultiplier__completion_completion(let rhsCompletion)):
                guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_list__term_termcompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case let .m_getRepoReliabilityMultiplier__completion_completion(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func list(term: Parameter<String>, completion: Parameter<(Result<[GitRepositoryModel], Error>) -> Void>) -> Verify { return Verify(method: .m_list__term_termcompletion_completion(`term`, `completion`))}
        public static func getRepoReliabilityMultiplier(completion: Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>) -> Verify { return Verify(method: .m_getRepoReliabilityMultiplier__completion_completion(`completion`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func list(term: Parameter<String>, completion: Parameter<(Result<[GitRepositoryModel], Error>) -> Void>, perform: @escaping (String, @escaping (Result<[GitRepositoryModel], Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_list__term_termcompletion_completion(`term`, `completion`), performs: perform)
        }
        public static func getRepoReliabilityMultiplier(completion: Parameter<(Result<GitRepoReliabilityMultiplierModel, Error>) -> Void>, perform: @escaping (@escaping (Result<GitRepoReliabilityMultiplierModel, Error>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_getRepoReliabilityMultiplier__completion_completion(`completion`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - GitRepositoriesListViewModelAnalyticsProtocol
open class GitRepositoriesListViewModelAnalyticsProtocolMock: GitRepositoriesListViewModelAnalyticsProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func itemSelected(name: String) {
        addInvocation(.m_itemSelected__name_name(Parameter<String>.value(`name`)))
		let perform = methodPerformValue(.m_itemSelected__name_name(Parameter<String>.value(`name`))) as? (String) -> Void
		perform?(`name`)
    }

    open func searched(term: String) {
        addInvocation(.m_searched__term_term(Parameter<String>.value(`term`)))
		let perform = methodPerformValue(.m_searched__term_term(Parameter<String>.value(`term`))) as? (String) -> Void
		perform?(`term`)
    }

    open func screen() {
        addInvocation(.m_screen)
		let perform = methodPerformValue(.m_screen) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_itemSelected__name_name(Parameter<String>)
        case m_searched__term_term(Parameter<String>)
        case m_screen

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_itemSelected__name_name(let lhsName), .m_itemSelected__name_name(let rhsName)):
                guard Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher) else { return false } 
                return true 
            case (.m_searched__term_term(let lhsTerm), .m_searched__term_term(let rhsTerm)):
                guard Parameter.compare(lhs: lhsTerm, rhs: rhsTerm, with: matcher) else { return false } 
                return true 
            case (.m_screen, .m_screen):
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_itemSelected__name_name(p0): return p0.intValue
            case let .m_searched__term_term(p0): return p0.intValue
            case .m_screen: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func itemSelected(name: Parameter<String>) -> Verify { return Verify(method: .m_itemSelected__name_name(`name`))}
        public static func searched(term: Parameter<String>) -> Verify { return Verify(method: .m_searched__term_term(`term`))}
        public static func screen() -> Verify { return Verify(method: .m_screen)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func itemSelected(name: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_itemSelected__name_name(`name`), performs: perform)
        }
        public static func searched(term: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_searched__term_term(`term`), performs: perform)
        }
        public static func screen(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_screen, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - ReliabilityRepoCalculatorUseCase
open class ReliabilityRepoCalculatorUseCaseMock: ReliabilityRepoCalculatorUseCase, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func execute(repoStats: GitRepoStatsModel, multiplier: Double) -> Double {
        addInvocation(.m_execute__repoStats_repoStatsmultiplier_multiplier(Parameter<GitRepoStatsModel>.value(`repoStats`), Parameter<Double>.value(`multiplier`)))
		let perform = methodPerformValue(.m_execute__repoStats_repoStatsmultiplier_multiplier(Parameter<GitRepoStatsModel>.value(`repoStats`), Parameter<Double>.value(`multiplier`))) as? (GitRepoStatsModel, Double) -> Void
		perform?(`repoStats`, `multiplier`)
		var __value: Double
		do {
		    __value = try methodReturnValue(.m_execute__repoStats_repoStatsmultiplier_multiplier(Parameter<GitRepoStatsModel>.value(`repoStats`), Parameter<Double>.value(`multiplier`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for execute(repoStats: GitRepoStatsModel, multiplier: Double). Use given")
			Failure("Stub return value not specified for execute(repoStats: GitRepoStatsModel, multiplier: Double). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_execute__repoStats_repoStatsmultiplier_multiplier(Parameter<GitRepoStatsModel>, Parameter<Double>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_execute__repoStats_repoStatsmultiplier_multiplier(let lhsRepostats, let lhsMultiplier), .m_execute__repoStats_repoStatsmultiplier_multiplier(let rhsRepostats, let rhsMultiplier)):
                guard Parameter.compare(lhs: lhsRepostats, rhs: rhsRepostats, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsMultiplier, rhs: rhsMultiplier, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_execute__repoStats_repoStatsmultiplier_multiplier(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func execute(repoStats: Parameter<GitRepoStatsModel>, multiplier: Parameter<Double>, willReturn: Double...) -> MethodStub {
            return Given(method: .m_execute__repoStats_repoStatsmultiplier_multiplier(`repoStats`, `multiplier`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func execute(repoStats: Parameter<GitRepoStatsModel>, multiplier: Parameter<Double>, willProduce: (Stubber<Double>) -> Void) -> MethodStub {
            let willReturn: [Double] = []
			let given: Given = { return Given(method: .m_execute__repoStats_repoStatsmultiplier_multiplier(`repoStats`, `multiplier`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Double).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func execute(repoStats: Parameter<GitRepoStatsModel>, multiplier: Parameter<Double>) -> Verify { return Verify(method: .m_execute__repoStats_repoStatsmultiplier_multiplier(`repoStats`, `multiplier`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func execute(repoStats: Parameter<GitRepoStatsModel>, multiplier: Parameter<Double>, perform: @escaping (GitRepoStatsModel, Double) -> Void) -> Perform {
            return Perform(method: .m_execute__repoStats_repoStatsmultiplier_multiplier(`repoStats`, `multiplier`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

