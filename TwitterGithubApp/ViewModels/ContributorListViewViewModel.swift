//
//  ContributorListViewViewModel.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 3/1/25.
//

import UIKit

protocol ContributorListViewViewModelDelegate: AnyObject {
    func didLoadContributors()
    func didSelectContributor(_ contributor: Contributor)
}

final class ContributorListViewViewModel : NSObject {
    
    public weak var delegate: ContributorListViewViewModelDelegate?
    
    
    private var cellViewModels: [ContributorCollectionViewCellViewModel] = []
    
    private var contributors: [Contributor] = [] {
        didSet {
            for contributor in contributors {
                let viewModel = ContributorCollectionViewCellViewModel(
                    login: contributor.login,
                    contributionsCount: contributor.contributions,
                    avatarURL: contributor.avatarURL
                )
                
                if( !cellViewModels.contains(viewModel) ) {
                    cellViewModels.append(viewModel)
                }
                
                
            }
        }
    }
    
    public func fetchContributions() {
        guard let request = Request.contributorListRequest else { return }
        Service.shared.execute(
            request,
            expecting: GetAllContributors.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.contributors = responseModel.contributors
                DispatchQueue.main.async {
                    self?.delegate?.didLoadContributors()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    
    
    
}


// MARK: - CollectionView

extension ContributorListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ContributorCollectionViewCell.identifier,
            for: indexPath
        ) as? ContributorCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let contributor = contributors[indexPath.row]
        delegate?.didSelectContributor(contributor)
    }

}
