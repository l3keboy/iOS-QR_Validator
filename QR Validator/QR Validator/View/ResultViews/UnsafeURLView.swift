//
//  UnsafeURLView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 17/07/2022.
//

import SwiftUI

struct UnsafeURLView: View {
    var body: some View {
        ZStack {
            Color("AccentColorRed").ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image(systemName: "shield.slash")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100, alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical, 24)
                
                Text("The scanned QR Code is an not a safe URL! \nThe URL is seen below and can be copied by tapping it, **open at your own risk**!")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Spacer()

                if APIViewModel.shared.latestAPIResponse?.matches?[0]?.threatType == "POTENTIALLY_HARMFUL_APPLICATION" {
                    Text("The site ahead may contain malware. Attackers might attempt to install dangerous apps on your device that steal or delete your information (for example, photos, passwords, messages, and credit cards).")
                        .italic()
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                } else if APIViewModel.shared.latestAPIResponse?.matches?[0]?.threatType == "MALWARE" {
                    Text("Visiting this web site may harm your computer. This page appears to contain malicious code that could be downloaded to your computer without your consent. You can learn more about harmful web content including viruses and other malicious code and how to protect your computer at [Google Search Central.](https://www.google.com/url?q=https://developers.google.com/search/docs/advanced/security/malware)")
                        .italic()
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                } else if APIViewModel.shared.latestAPIResponse?.matches?[0]?.threatType == "SOCIAL_ENGINEERING" {
                    Text("Deceptive site ahead. Attackers on this URL may trick you into doing something dangerous like installing software or revealing your personal information (for example, passwords, phone numbers, or credit cards). You can find out more about social engineering (phishing) from [www.antiphishing.org.](https://antiphishing.org/)")
                        .italic()
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                } else if APIViewModel.shared.latestAPIResponse?.matches?[0]?.threatType == "UNWANTED_SOFTWARE" {
                    Text("The site ahead may contain harmful programs. Attackers might attempt to trick you into installing programs that harm your browsing experience (for example, by changing your homepage or showing extra ads on sites you visit).")
                        .italic()
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                } else {
                    Text("The type of this threat is unknown!")
                        .italic()
                        .padding(.horizontal, 16)
                        .multilineTextAlignment(.center)
                }
                                
                Spacer()
                
                Text("Scanned URL: \(APIViewModel.shared.latestScannedURL!)")
                    .padding(.bottom, 16)
                    .foregroundColor(.white)
                    .onTapGesture {
                        UIPasteboard.general.setValue("\(APIViewModel.shared.latestScannedURL!)", forPasteboardType: "public.plain-text")
                    }
            }
        }
    }
}

struct UnsafeURLView_Previews: PreviewProvider {
    static var previews: some View {
        UnsafeURLView()
    }
}
