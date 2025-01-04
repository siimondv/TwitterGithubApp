//
//  OrganizationViewViewModel.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 1/1/25.
//
	
import Foundation

protocol OrganizationViewViewModelDelegate: AnyObject {
    func didFetchOrganization(_ organization: Organization)
}

final class OrganizationViewViewModel {
    
    weak var delegate: OrganizationViewViewModelDelegate?
    private var organization: Organization?
    
    func getOrganization() {
        Service.shared.execute(Request.organizationRequest, expecting: Organization.self) { [weak self] result in
            switch result {
            case .success(let organization):
                self?.organization = organization
                self?.delegate?.didFetchOrganization(organization)
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
