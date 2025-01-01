//
//  Organization.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import Foundation

struct Organization: Codable {
    let description: String
    let forksCount: Int
    let visibility: String
    let watchers: Int
    let organizationDetails: OrganizationDetails

    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case description
        case forksCount = "forks_count"
        case visibility
        case watchers
        case organizationDetails = "organization"
    }

    struct OrganizationDetails: Codable {
        let login: String
        let avatarURL: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
        }
    }
}
