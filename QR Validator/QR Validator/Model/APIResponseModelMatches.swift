//
//  APIResponseModelMatches.swift
//  QR Validator
//
//  Created by Luke Hendriks on 18/07/2022.
//

import Foundation


struct APIResponseModelMatches: Codable {
    var threatType: String?              // Maybe enum? struct?
    var platformType: String?            // Maybe enum? struct?
    var threatEntryType: String?         // Maybe enum? struct?
    var threat: APIResponseModelMatchesData?
    var threatEntryMetadata: [APIResponseModelMatchesEntries?]?
    var cacheDuration: String?
    
}
