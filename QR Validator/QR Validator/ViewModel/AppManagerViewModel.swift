//
//  AppManagerViewModel.swift
//  QR Validator
//
//  Created by Luke Hendriks on 16/07/2022.
//

import Foundation

class AppManagerViewModel {
    var isActive = true
    static var shared = AppManagerViewModel()
    private init() {}
}
