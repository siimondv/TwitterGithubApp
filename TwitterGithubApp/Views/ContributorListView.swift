//
//  ContributorView.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 3/1/25.
//

import UIKit

protocol ContributorListViewDelegate: AnyObject {
    func contributorListView(
        _ contributorListView: ContributorListView,
        didSelectContributor contributor: Contributor
    )
    
}

final class ContributorListView: UIView {
    
    public weak var delegate: ContributorListViewDelegate?
    
    private let viewModel = ContributorListViewViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ContributorCollectionViewCell.self, forCellWithReuseIdentifier: ContributorCollectionViewCell.identifier)
        collectionView.isHidden = true
        collectionView.alpha = 0
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        setUpConstraints()
        viewModel.delegate = self
        viewModel.fetchContributions()
        setUpCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
}

extension ContributorListView: ContributorListViewViewModelDelegate {
    func didSelectContributor(_ contributor: Contributor) {
        delegate?.contributorListView( self, didSelectContributor: contributor)
    }
    
    func didLoadContributors() {
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
}


