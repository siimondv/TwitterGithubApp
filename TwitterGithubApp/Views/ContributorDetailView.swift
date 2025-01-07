//
//  ContributorDetailView.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 6/1/25.
//

import UIKit

final class ContributorDetailView: UIView {
    
    private let viewModel: ContributorDetailViewViewModel
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, viewModel: ContributorDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(spinner, imageView, nameLabel, bioLabel, locationLabel)
        addConstraints()
        configure()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.getContributorWithDetails()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Layout and Setup
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // Spinner Constraints
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Image View Constraints
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            // Name Label Constraints
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Bio Label Constraints
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            bioLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            // Location Label Constraints
            locationLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func configure() {
        imageView.isHidden = true
        nameLabel.isHidden = true
        bioLabel.isHidden = true
        locationLabel.isHidden = true
    }
}

extension ContributorDetailView: ContributorDetailViewViewModelDelegate {
    func didFetchContributorWithDetails(_ contributorWithDetails: ContributorWithDetails, _ contributor: Contributor) {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()
            
            self?.imageView.isHidden = false
            self?.nameLabel.isHidden = false
            self?.bioLabel.isHidden = false
            self?.locationLabel.isHidden = false
            
            self?.nameLabel.text = contributorWithDetails.login
            self?.bioLabel.text = contributorWithDetails.bio
            self?.locationLabel.text = "Location: \(contributorWithDetails.location)"
            
            self?.viewModel.fetchImage(from: contributor.avatarURL) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.imageView.image = UIImage(data: data)
                    case .failure(let error):
                        print("Failed to load image: \(error)")
                    }
                }
            }
        }
    }
}
