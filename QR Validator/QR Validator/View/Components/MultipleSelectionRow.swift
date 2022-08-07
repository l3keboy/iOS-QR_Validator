//
//  MultipleSelectionRow.swift
//  QR Validator
//
//  Created by Luke Hendriks on 19/07/2022.
//

import SwiftUI

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                Spacer()
                if self.isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
    }
}
