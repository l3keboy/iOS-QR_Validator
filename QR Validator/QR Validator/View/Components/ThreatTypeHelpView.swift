//
//  ThreatTypeHelpView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 19/07/2022.
//

import SwiftUI

struct ThreatTypeHelpView: View {
    var threatTypeTitle: String
    var threatTypeDescription: String
    var body: some View {
        VStack {
            HStack{
                Text(threatTypeTitle)
                    .foregroundColor(.white)
                    .opacity(0.75)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 2)
                Spacer()
            }
            Text(threatTypeDescription)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
        }
    }
}
