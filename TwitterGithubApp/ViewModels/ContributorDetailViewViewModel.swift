//
//  ContributorDetailViewViewModel.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 4/1/25.
//

import Foundation

protocol ContributorDetailViewViewModelDelegate: AnyObject {
    func didFetchContributorWithDetails(_ contributorWithDetails: ContributorWithDetails, _ contributor: Contributor)
}
final class ContributorDetailViewViewModel {
    
    private let contributor: Contributor
    private var contributorWithDetails: ContributorWithDetails?
    weak var delegate: ContributorDetailViewViewModelDelegate?
    
    init(contributor: Contributor) {
        self.contributor = contributor
    }
    
    func getContributorWithDetails() {
        
        guard let url = URL(string: ("https://api.github.com/users/") + contributor.login ) else {
            return
        }
        guard let request = Request(url: url) else {
            return
        }
        Service.shared.execute(request, expecting: ContributorWithDetails.self) { [weak self] result in
            switch result {
            case .success(let contributorWithDetails):
                guard (self != nil) else { return }
                self!.contributorWithDetails = contributorWithDetails
                self!.delegate?.didFetchContributorWithDetails(contributorWithDetails, self!.contributor)
            case .failure(let error):
                print("Failed to fetch organization: \(error)")
            }
        }
    }
    
    func fetchImage(from urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
            guard let url = URL(string: urlString) else {
                completion(.failure(URLError(.badURL)))
                return
            }
        
        ImageLoader.shared.downloadImage(url, completion: completion)
        }
}
