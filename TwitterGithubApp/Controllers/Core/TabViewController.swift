//
//  RMTabViewController.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import UIKit

/// Controller to house tabs and root tab controllers
final class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }

    private func setUpTabs() {
        
        let organizationsVC = OrganizationViewController()
        let contributorsVC = ContributorViewController()
        
        organizationsVC.navigationItem.largeTitleDisplayMode = .automatic
        contributorsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        
        

        let nav1 = UINavigationController(rootViewController: organizationsVC)
        let nav2 = UINavigationController(rootViewController: contributorsVC)

        nav1.tabBarItem = UITabBarItem(title: "Organization",
                                       image: UIImage(systemName: "building.2.crop.circle"),
                                       tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Contributors",
                                       image: UIImage(systemName: "person.2.fill"),
                                       tag: 2)

        for nav in [nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers(
            [nav1, nav2],
            animated: true
        )
    }
}

