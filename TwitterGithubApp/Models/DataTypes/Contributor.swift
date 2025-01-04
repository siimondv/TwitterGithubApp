//
//  Contributor.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 3/1/25.
//

struct Contributor: Codable {
    let login: String
    let avatarURL: String
    let contributions: Int

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case contributions
    }
}
