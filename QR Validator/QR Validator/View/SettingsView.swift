//
//  SettingsView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 17/07/2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.scenePhase) var scenePhase

    private let AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY = "automaticallyOpenSafeURLS"
    private let USE_IN_APP_BROWSER_FORKEY = "useInAppBrowser"
    private let SELECTED_THREAT_TYPES_FORKEY = "selectedThreatTypes"
    @State var automaticallyOpenSafeUrls = false
    @State var useInAppBrowser = false
    
    let threatTypes = ["THREAT_TYPE_UNSPECIFIED": "Unspecified threat types", "MALWARE": "Malware", "SOCIAL_ENGINEERING": "Social engineering", "UNWANTED_SOFTWARE": "Unwanted software", "POTENTIALLY_HARMFUL_APPLICATION": "Potentially harmful application"]
    @State var selectedThreatTypes: [String] = ["THREAT_TYPE_UNSPECIFIED", "MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE", "POTENTIALLY_HARMFUL_APPLICATION"]

    var body: some View {
        ZStack {
            Color("PrimaryColor").ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Group {
                        HStack {
                            Text("Safe URL Settings")
                                .bold()
                                .foregroundColor(.white)
                                .opacity(0.75)
                                .padding(.top, 24)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 2)
                            Spacer()
                        }
                        Divider()
                            .padding(.horizontal, 16)
                        Toggle("Automatically open safe URLs", isOn: $automaticallyOpenSafeUrls)
                            .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                        Toggle("Use in app browser for opening URLs", isOn: $useInAppBrowser)
                            .toggleStyle(SwitchToggleStyle(tint: Color("AccentColor")))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                    }
                    
                    Group {
                        HStack {
                            Text("Select threat types")
                                .bold()
                                .foregroundColor(.white)
                                .opacity(0.75)
                                .padding(.top, 24)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 2)
                            Spacer()
                        }
                        Divider()
                            .padding(.horizontal, 16)
                        ForEach(threatTypes.sorted(by: >), id: \.key) { threatTypeKey, threatTypeValue in
                            MultipleSelectionRow(title: threatTypeValue, isSelected: self.selectedThreatTypes.contains(threatTypeKey)) {
                                if self.selectedThreatTypes.contains(threatTypeKey) {
                                    self.selectedThreatTypes.removeAll(where: { $0 == threatTypeKey })
                                }
                                else {
                                    self.selectedThreatTypes.append(threatTypeKey)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Help and privacy")
                                .bold()
                                .foregroundColor(.white)
                                .opacity(0.75)
                                .padding(.top, 24)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 2)
                            Spacer()
                        }
                        Divider()
                            .padding(.horizontal, 16)
                        HStack {
                            NavigationLink(destination: HelpView()) {
                                Text("Help")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.all, 16)
                        }
                        HStack {
                            NavigationLink(destination: PrivacyView()) {
                                Text("Privacy")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.all, 16)
                        }
                    }
                            
                    Spacer()
                    
                    FooterView()
                    
                    Spacer()
                }
            }
        }
        .foregroundColor(.white)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: automaticallyOpenSafeUrls) { newValue in
            UserDefaults.standard.set(newValue, forKey: AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY)
        }
        .onChange(of: useInAppBrowser) { newValue in
            UserDefaults.standard.set(newValue, forKey: USE_IN_APP_BROWSER_FORKEY)
        }
        .onChange(of: selectedThreatTypes, perform: { newValue in
            UserDefaults.standard.set(newValue, forKey: SELECTED_THREAT_TYPES_FORKEY)
        })
        .onChange(of: scenePhase) { newPhase in
            switch newPhase {
            case .active:
                AppManagerViewModel.shared.isActive = true
                automaticallyOpenSafeUrls = UserDefaults.standard.bool(forKey: AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY)
                useInAppBrowser = UserDefaults.standard.bool(forKey: USE_IN_APP_BROWSER_FORKEY)
                selectedThreatTypes = UserDefaults.standard.array(forKey: SELECTED_THREAT_TYPES_FORKEY) as? [String] ?? ["THREAT_TYPE_UNSPECIFIED", "MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE", "POTENTIALLY_HARMFUL_APPLICATION"]
            case .background:
                AppManagerViewModel.shared.isActive = false
            case .inactive:
                if AppManagerViewModel.shared.isActive == true {
                    automaticallyOpenSafeUrls = UserDefaults.standard.bool(forKey: AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY)
                    useInAppBrowser = UserDefaults.standard.bool(forKey: USE_IN_APP_BROWSER_FORKEY)
                    selectedThreatTypes = UserDefaults.standard.array(forKey: SELECTED_THREAT_TYPES_FORKEY) as? [String] ?? ["THREAT_TYPE_UNSPECIFIED", "MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE", "POTENTIALLY_HARMFUL_APPLICATION"]
                }
            @unknown default:
                return
            }
        }
        .onAppear {
            automaticallyOpenSafeUrls = UserDefaults.standard.bool(forKey: AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY)
            useInAppBrowser = UserDefaults.standard.bool(forKey: USE_IN_APP_BROWSER_FORKEY)
            selectedThreatTypes = UserDefaults.standard.array(forKey: SELECTED_THREAT_TYPES_FORKEY) as? [String] ?? ["THREAT_TYPE_UNSPECIFIED", "MALWARE", "SOCIAL_ENGINEERING", "UNWANTED_SOFTWARE", "POTENTIALLY_HARMFUL_APPLICATION"]
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
