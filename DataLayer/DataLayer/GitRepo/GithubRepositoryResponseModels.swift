public struct GithubResponseData: Codable {
    public var items: [GithubRepositoryData] = []
    public init() {}
}

public struct GithubRepositoryData: Codable {
    public var name: String = ""
    public var description: String? = ""
    public var stargazers_count: Int = 0
    public var forks_count: Int = 0
    public var open_issues_count: Int = 0
    public var owner: GithubRepositoryOwner = .init()
    public init() {}
}

public struct GithubRepositoryOwner: Codable {
    public var login: String = ""
    public var avatar_url: String = ""
    public init() {}
}
