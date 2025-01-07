//
//  RMRequest.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import Foundation

final class Request {
    /// Full URL for the request
    public let url: URL

    /// HTTP Method (default: GET)
    public let httpMethod: String

    /// Query Parameters, if any
    public let queryParameters: [URLQueryItem]

    // MARK: - Initializers

    /// Initialize with a full URL
    /// - Parameters:
    ///   - url: The full URL to initialize the request
    ///   - httpMethod: HTTP method (default: GET)
    public init?(url: URL, httpMethod: String = "GET") {
        self.url = url
        self.httpMethod = httpMethod

        // Parse query parameters
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        self.queryParameters = components?.queryItems ?? []
    }

    /// Initialize with a path and query parameters
    /// - Parameters:
    ///   - path: The path of the URL
    ///   - queryParameters: Query parameters to be appended
    ///   - httpMethod: HTTP method (default: GET)
    public init(
        path: String,
        queryParameters: [URLQueryItem] = [],
        httpMethod: String = "GET"
    ) {
        var components = URLComponents()
        components.path = path
        components.queryItems = queryParameters

        guard let url = components.url else {
            fatalError("Invalid URL components")
        }

        self.url = url
        self.httpMethod = httpMethod
        self.queryParameters = queryParameters
    }
}

extension Request {
    static let organizationRequest = Request(url: URL(string: Constants.organizationURL)!)
    static let contributorListRequest = Request(url: URL(string: Constants.contributorsURL)!)
}
