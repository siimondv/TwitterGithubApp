//
//  RMOrganizationViewController.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import UIKit

final class RMOrganizationViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Organization"
        
        RMService.shared.execute(RMRequest.organizationRequest, expecting: Organization.self) { result in
            switch result {
            case .success(let organization):
                print("Organization Description: \(organization.description)")
                print("Forks Count: \(organization.forksCount)")
                print("Visibility: \(organization.visibility)")
                print("Watchers: \(organization.watchers)")
                print("Login: \(organization.organizationDetails.login)")
                print("Avatar URL: \(organization.organizationDetails.avatarURL)")
            case .failure(let error):
                print("Failed to fetch organization: \(error)")
            }
        }
    }
}
