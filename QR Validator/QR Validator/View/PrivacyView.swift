//
//  PrivacyView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 18/07/2022.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()
            ScrollView {
                Group {
                    HStack {
                        Text("Data collection")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .opacity(0.75)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal, 16)
                    Text("This app does not collect any user data nor does it collect any device data!")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 2)
                }
                
                Group {
                    HStack {
                        Text("Google safe browsing")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .opacity(0.75)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal, 16)
                    Text("Checking the safety on a scanned URL behind a QR Code is done via the Google Safe browsing API. The documentation of this API can be found ***[here.](https://developers.google.com/safe-browsing/)*** \n\nThe Google Safe Browsing ***[Terms of service](https://developers.google.com/safe-browsing/v4/terms)*** apply.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 2)
                }
                
                Group {
                    HStack {
                        Text("Encryption")
                            .bold()
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .opacity(0.75)
                            .padding(.top, 24)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                        Spacer()
                    }
                    Divider()
                        .padding(.horizontal, 16)
                    Text("This app does not use any on device encryption, it does however, make HTTPS calls to the Google Safe Browsing API. This HTTPS call uses TLS encryption.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 2)
                }
                
                Spacer()
                
                FooterView()
                    .padding(.vertical, 16)
                
                Spacer()
            }
        }
        .foregroundColor(.white)
        .navigationTitle("Pivacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyView()
    }
}
