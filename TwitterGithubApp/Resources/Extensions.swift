//
//  Extensions.swift
//  TwitterGithubApp
//
//  Created by Simon Delgado on 2/1/25.
//

import UIKit

extension UIView {
    /// Add multiple subviews
    /// - Parameter views: Variadic views
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
