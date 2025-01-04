//
//  RMOrganizationViewController.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import UIKit

final class OrganizationViewController: UIViewController {

    private let organizationView = OrganizationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Organization"
        view.backgroundColor = .systemBackground
        setUpView()

    }
    
    private func setUpView() {
        view.addSubview(organizationView)
        NSLayoutConstraint.activate([
            organizationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            organizationView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            organizationView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            organizationView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    
}
