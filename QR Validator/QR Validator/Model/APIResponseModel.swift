//
//  APIResponseModel.swift
//  QR Validator
//
//  Created by Luke Hendriks on 18/07/2022.
//

import Foundation


struct APIResponseModel: Codable {
    var matches: [APIResponseModelMatches?]?
}
