//
//  RMRequest.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import Foundation

/// Object that represents a singlet API call
final class RMRequest {
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://api.github.com/repos/twitter/opensource-website"
    }

    /// Desired endpoint (optional)
    private let endpoint: RMEndpoint?

    /// Path components for API, if any
    private let pathComponents: [String]

    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]

    /// Constructed url for the API request in string format
    private var urlString: String {
        var string = Constants.baseUrl

        if let endpoint = endpoint {
            string += "/\(endpoint.rawValue)"
        }

        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }

        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap {
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            string += argumentString
        }

        return string
    }

    /// Computed & constructed API URL
    public var url: URL? {
        return URL(string: urlString)
    }

    /// Desired HTTP method
    public let httpMethod = "GET"

    // MARK: - Public

    /// Construct request
    /// - Parameters:
    ///   - endpoint: Optional target endpoint
    ///   - pathComponents: Collection of Path components
    ///   - queryParameters: Collection of query parameters
    public init(
        endpoint: RMEndpoint? = nil,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

extension RMRequest {
    static let organizationRequest = RMRequest()
    static let contributorListRequest = RMRequest(endpoint: .contributors)
}
