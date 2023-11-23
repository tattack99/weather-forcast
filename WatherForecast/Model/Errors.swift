//
//  Errors.swift
//  WatherForecast
//
//  Created by Tim Johansson on 2023-11-23.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case statusCodeNotOK
    case badURL
}

enum ParserError: Error {
    case invalidStringEncoding
    case couldNotParse
}
