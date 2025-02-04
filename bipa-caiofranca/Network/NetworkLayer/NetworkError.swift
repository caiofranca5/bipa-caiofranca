//
//  NetworkError.swift
//  bipa-caiofranca
//
//  Created by Caio França on 04/02/25.
//


import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serverError
    case invalidResponse
    case invalidURL
    case decodingError
    case unknown
    
    var description: String {
        switch self {
        case .badRequest:
            return "Invalid Network Request"
        case .unauthorized:
            return "Invalid API Credentials"
        case .forbidden:
            return "Access Denied"
        case .notFound:
            return "Resource Not Found"
        case .serverError:
            return "Internal server error occurred."
        case .invalidResponse:
            return "Invalid Network Response"
        case .invalidURL:
            return "Invalid Network URL"
        case .decodingError:
            return "Failed to Decode Data"
        case .unknown:
            return "Unknown Network Error"
        }
    }
}