//
//  SuccessURLView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 17/07/2022.
//

import SwiftUI

struct SafeURLView: View {
    @Environment(\.openURL) var openURL

    private let USE_IN_APP_BROWSER_FORKEY = "useInAppBrowser"
    @State var showingInAppBrowser = false

    var body: some View {
        ZStack {
            Color("AccentColorGreen").ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(systemName: "checkmark.shield")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 115, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 24)
                
                Text("The scanned QR Code is an safe URL!")
                    .padding(.vertical, 24)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                HStack {
                    Button("Open URL") {
                        if UserDefaults.standard.bool(forKey: USE_IN_APP_BROWSER_FORKEY) {
                            showingInAppBrowser = true
                        } else {
                            openURL(APIViewModel.shared.latestScannedURL!)
                        }
                    }
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
                    
                    
                    Button("Copy URL") {
                        UIPasteboard.general.setValue("\(APIViewModel.shared.latestScannedURL!)", forPasteboardType: "public.plain-text")
                    }
                    .padding(.horizontal, 16)
                    .foregroundColor(.white)
                }
                .padding(.bottom, 16)
            }
        }
        .fullScreenCover(isPresented: $showingInAppBrowser) {
            SafariViewWrapper(url: APIViewModel.shared.latestScannedURL!).ignoresSafeArea()
        }
    }
}

struct SafeURLView_Previews: PreviewProvider {
    static var previews: some View {
        SafeURLView()
    }
}
