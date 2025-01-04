//
//  GetAllContributors.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 3/1/25.
//

struct GetAllContributors: Codable {
    let contributors: [Contributor]

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.contributors = try container.decode([Contributor].self)
    }
}
