//
//  RMService.swift
//  BookApp
//
//  Created by Simon Delgado on 1/1/25.
//

import Foundation

final class Service {
    /// Shared singleton instance
    static let shared = Service()

    /// Private constructor to enforce singleton usage
    private init() {}

    enum ServiceError: Error {
        case invalidURL
        case requestFailed
        case decodingFailed
    }

    /// Execute an API request
    /// - Parameters:
    ///   - request: The `Request` instance
    ///   - type: The expected Codable type
    ///   - completion: Completion handler with success or failure
    public func execute<T: Codable>(
        _ request: Request,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        // Create URLRequest from the Request instance
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod

        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.requestFailed))
                return
            }

            do {
                // Decode the data
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ServiceError.decodingFailed))
            }
        }
        task.resume()
    }
}
