//
//  ErrorResultView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 17/07/2022.
//

import SwiftUI

struct ErrorResultView: View {
    var body: some View {
        ZStack {
            Color("AccentColorRed").ignoresSafeArea()
            
            VStack {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 24)

                Text("The scanned QR Code is an URL! But an error occurred")
                    .padding(.vertical, 24)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(APIViewModel.shared.latestError?.description ?? "No error occurred!")
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ErrorResultView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorResultView()
    }
}
