//
//  CustomErrors.swift
//  QR Validator
//
//  Created by Luke Hendriks on 17/07/2022.
//

import Foundation


enum CustomErrors: Error {
    case unknownError
    case badRequest
    case APIKeyError
}

extension CustomErrors: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknownError:
            return "An unknown error occured!"
        case .badRequest:
            return "Bad request!"
        case .APIKeyError:
            return "Something is wrong with the API key or it is missing!"
        }
    }
}
