//
//  FooterView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 19/07/2022.
//

import SwiftUI

struct FooterView: View {
    @State var date = Date().formatted(.dateTime.year())
    
    var body: some View {
        VStack {
            Text("© \(date) QR-Validator")
                .font(.system(size: 12))
                .padding(.horizontal, 16)
                .foregroundColor(.gray)
            Text("Built by [Luke Hendriks](https://lukehendriks.net)")
                .font(.system(size: 12))
                .padding(.horizontal, 16)
                .foregroundColor(.gray)
        }
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
