struct GithubResponseData: Codable {
    let items: [GithubRepositoryData]
}

struct GithubRepositoryData: Codable {
    let name: String
    let description: String?
    let stargazers_count: Int
    let forks_count: Int
    let open_issues_count: Int
    let owner: GithubRepositoryOwner
}

struct GithubRepositoryOwner: Codable {
    let login: String
    let avatar_url: String
}
