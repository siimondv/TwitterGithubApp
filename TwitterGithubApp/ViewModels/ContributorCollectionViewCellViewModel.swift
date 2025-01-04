//
//  ContributorCollectionViewCellViewModel.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 3/1/25.
//

import Foundation

final class ContributorCollectionViewCellViewModel: Equatable, Hashable{
    public let login: String
    private let contributionsCount: Int
    private let avatarURL: String
    
    // MARK: - Init
    
    init(
        login: String,
        contributionsCount: Int,
        avatarURL: String
    ) {
        self.login = login
        self.contributionsCount = contributionsCount
        self.avatarURL = avatarURL
    }
    
    public var contributionsCountText: String {
        return "Contributions: \(contributionsCount)"
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: avatarURL) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    static func == (lhs: ContributorCollectionViewCellViewModel, rhs: ContributorCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
        hasher.combine(contributionsCount)
        hasher.combine(avatarURL)
    }
    
}
