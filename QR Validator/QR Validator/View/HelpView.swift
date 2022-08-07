//
//  HelpView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 18/07/2022.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()
            ScrollView {
                Group {
                    HStack {
                        Text("The camera is not showing.")
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
                    Text("If the camera is not showing, please close the app and make sure the app has the permissions to access the camera. After giving the permissions relaunch the app.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 2)
                }
                
                Group {
                    HStack {
                        Text("What do the different settings mean?")
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
                    
                    Group {
                        HStack {
                            Text("URL Settings")
                                .bold()
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .opacity(0.75)
                                .padding(.top, 2)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 2)
                            Spacer()
                        }
                        Text("There are two settings regarding a scanned URL: \n  - Automatically open safe URLs; \n  - Use in app browser for opening URLs; \n\nWhen 'Automatically open safe URLs' is turned on, any safe URL is automatically opened, otherwise a safe URL screen will be shown from where the URL can be opened if desired. \n\nWhen 'Use in app browser for opening URLs' is turned on, an in app browser will be used when opening an app, otherwise the Safari application will be opened.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 2)
                    }
                    
                    Group {
                        HStack {
                            Text("Threat Type Settings")
                                .bold()
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .opacity(0.75)
                                .padding(.top, 24)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 2)
                            Spacer()
                        }
                        
                        ThreatTypeHelpView(threatTypeTitle: "Unspecified threat type", threatTypeDescription: "This is an unknown threat.")
                        
                        ThreatTypeHelpView(threatTypeTitle: "Malware", threatTypeDescription: "Visiting this web site may harm your computer. This page appears to contain malicious code that could be downloaded to your computer without your consent. You can learn more about harmful web content including viruses and other malicious code and how to protect your computer at Google Search Central.")
                            .padding(.top, 4)
                        Text("[Google Search Central Policy](https://www.google.com/url?q=https://developers.google.com/search/docs/advanced/security/malware)")
                            .bold()
                            .italic()
                            .padding(.horizontal, 16)
                            .padding(.top, 0.1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ThreatTypeHelpView(threatTypeTitle: "Social engineering", threatTypeDescription: "Deceptive site ahead. Attackers on this URL may trick you into doing something dangerous like installing software or revealing your personal information (for example, passwords, phone numbers, or credit cards). You can find out more about social engineering (phishing) from www.antiphishing.org.")
                            .padding(.top, 4)
                        
                        ThreatTypeHelpView(threatTypeTitle: "Unwanted software", threatTypeDescription: "The site ahead may contain harmful programs. Attackers might attempt to trick you into installing programs that harm your browsing experience (for example, by changing your homepage or showing extra ads on sites you visit).")
                            .padding(.top, 4)
                        Text("[Unwanted Software Policy](http://www.google.com/about/company/unwanted-software-policy.html)")
                            .bold()
                            .italic()
                            .padding(.horizontal, 16)
                            .padding(.top, 0.1)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ThreatTypeHelpView(threatTypeTitle: "Potentially harmful application", threatTypeDescription: "The site ahead may contain malware. Attackers might attempt to install dangerous apps on your device that steal or delete your information (for example, photos, passwords, messages, and credit cards).")
                            .padding(.top, 4)
                    }
                }
                
                Spacer()
                
                FooterView()
                    .padding(.vertical, 16)
                
                Spacer()
            }
        }
        .foregroundColor(.white)
        .navigationTitle("Help")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
