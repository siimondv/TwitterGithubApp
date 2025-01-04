//
//  RMContributorViewController.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import UIKit

final class ContributorViewController: UIViewController {
    
    private let contributorListView = ContributorListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contributors"
        view.backgroundColor = .systemBackground
        setUpView()
        
    }
    
    private func setUpView() {
        view.addSubview(contributorListView)
        NSLayoutConstraint.activate([
            contributorListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contributorListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contributorListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            contributorListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
