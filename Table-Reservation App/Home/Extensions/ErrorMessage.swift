//
//  Error.swift
//  Table-Reservation App
//
//  Created by Tatiana Simmer on 07/11/2023.
//

import Foundation

enum APIError: Error {
    case unknownError
    case invalidData
    case authenticationError
    case serverUnavailable

    var errorMessage: String {
        switch self {
        case .unknownError:
            return "Unexpected response from the server"
        case .invalidData:
            return "Invalid data received"
        case .authenticationError:
            return "Authentication failed"
        case .serverUnavailable:
            return "The server is currently unavailable"
        }
    }
}
