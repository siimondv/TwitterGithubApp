//
//  ContributorDetailViewController.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 4/1/25.
//

import UIKit

final class ContributorDetailViewController: UIViewController {
    
    private let contributorDetailView : ContributorDetailView
    
    init(viewmodel : ContributorDetailViewViewModel){

        contributorDetailView = ContributorDetailView(frame: .zero, viewModel: viewmodel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("unsupported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Contributors Detail "
        view.backgroundColor = .systemBackground
        view.addSubview(contributorDetailView)
        addConstraints()
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contributorDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contributorDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            contributorDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            contributorDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    

}
