//
//  NetworkError.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

enum NetworkError: Error {
    case httpError(Int)
    case serverError
    case somethingWentWrong
    case modelNotCorrect
    case other(Error)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .httpError(let statusCode):
            return "HTTP Error: \(statusCode)"
        case .serverError:
            return "Unfortunitly Server Error!, try again later"
        case .somethingWentWrong:
            return "There is an error occured, try again later"
        case .modelNotCorrect:
            return "Response Model Not Correct"
        case .other(let error):
            return error.localizedDescription
        }
    }
}
