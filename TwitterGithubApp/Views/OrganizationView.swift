//
//  OrganizationView.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 1/1/25.
//

import UIKit

final class OrganizationView: UIView {

    let viewModel = OrganizationViewViewModel()

    // MARK: - UI Elements

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

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let forksLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let visibilityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let watchersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground

        addSubviews(spinner, imageView, nameLabel, descriptionLabel, forksLabel, visibilityLabel, watchersLabel)
        addConstraints()
        configure()

        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.getOrganization() // Fetch organization data
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

            // Description Label Constraints
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Forks Label Constraints
            forksLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            forksLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            forksLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Visibility Label Constraints
            visibilityLabel.topAnchor.constraint(equalTo: forksLabel.bottomAnchor, constant: 10),
            visibilityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            visibilityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            // Watchers Label Constraints
            watchersLabel.topAnchor.constraint(equalTo: visibilityLabel.bottomAnchor, constant: 10),
            watchersLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            watchersLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }

    private func configure() {
        // Hide UI elements until data is loaded
        imageView.isHidden = true
        nameLabel.isHidden = true
        descriptionLabel.isHidden = true
        forksLabel.isHidden = true
        visibilityLabel.isHidden = true
        watchersLabel.isHidden = true
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self?.imageView.image = UIImage(data: data)
            }
        }.resume()
    }
}

// MARK: - OrganizationViewViewModelDelegate

extension OrganizationView: OrganizationViewViewModelDelegate {
    func didFetchOrganization(_ organization: Organization) {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.stopAnimating()

            self?.imageView.isHidden = false
            self?.nameLabel.isHidden = false
            self?.descriptionLabel.isHidden = false
            self?.forksLabel.isHidden = false
            self?.visibilityLabel.isHidden = false
            self?.watchersLabel.isHidden = false

            self?.nameLabel.text = organization.organizationDetails.login
            self?.descriptionLabel.text = organization.description
            self?.forksLabel.text = "Forks: \(organization.forksCount)"
            self?.visibilityLabel.text = "Visibility: \(organization.visibility)"
            self?.watchersLabel.text = "Watchers: \(organization.watchers)"

            if let url = URL(string: organization.organizationDetails.avatarURL) {
                self?.loadImage(from: url)
            }
        }
    }
}
