//
//  SafariViewWrapper.swift
//  QR Validator
//
//  Created by Luke Hendriks on 18/07/2022.
//

import Foundation
import SwiftUI
import SafariServices

struct SafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewWrapper>) {
        return
    }
}
