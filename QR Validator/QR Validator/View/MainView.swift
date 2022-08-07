//
//  MainView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 16/07/2022.
//

import SwiftUI

struct MainView: View {
    @Environment(\.openURL) var openURL
    @Environment(\.scenePhase) var scenePhase

    let cameraModel = CameraModel()
    private let AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY = "automaticallyOpenSafeURLS"
    private let USE_IN_APP_BROWSER_FORKEY = "useInAppBrowser"
    
    @State var moveToErrorResultView = false
    @State var moveToSaveURLView = false
    @State var moveToUnsaveURLView = false
    @State var showingNoURLAlert = false
    @State var showingInAppBrowser = false
    @State var cameraRotationdegrees = 0.0
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CameraView(cameraModel: cameraModel) { result in
                        switch result {
                        case .success(let readableObjects):
                            if cameraModel.qrCodeContentIsURL(readableObjects.stringValue!) {
                                cameraModel.stopSession()
                                APIViewModel.shared.checkURLSafety(urlToCheck: URL(string: readableObjects.stringValue!)!) { isSafe, error in
                                    if error != nil {
                                        moveToErrorResultView = true
                                        return
                                    }
                                    if isSafe == nil {
                                        moveToErrorResultView = true
                                    } else {
                                        if isSafe! == true {
                                            if UserDefaults.standard.bool(forKey: AUTOMATICALLY_OPEN_SAFE_URLS_FORKEY) {
                                                if UserDefaults.standard.bool(forKey: USE_IN_APP_BROWSER_FORKEY) {
                                                    showingInAppBrowser = true
                                                } else {
                                                    openURL(APIViewModel.shared.latestScannedURL!)
                                                }
                                            } else {
                                                moveToSaveURLView = true
                                            }
                                        } else {
                                            moveToUnsaveURLView = true
                                        }
                                    }
                                }
                            } else {
                                cameraModel.session?.stopRunning()
                                showingNoURLAlert = true
                            }
                        case .failure(_):
                            cameraModel.session?.stopRunning()
                            moveToErrorResultView = true
                        }
                    }
                    .ignoresSafeArea()
                }
                
                NavigationLink(destination: SafeURLView(), isActive: $moveToSaveURLView) { EmptyView() }
                NavigationLink(destination: UnsafeURLView(), isActive: $moveToUnsaveURLView) { EmptyView() }
                NavigationLink(destination: ErrorResultView(), isActive: $moveToErrorResultView) { EmptyView() }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Label("Settings", systemImage: "gearshape")
                    }
                }
            }
            .onChange(of: scenePhase) { newPhase in
                switch newPhase {
                case .active:
                    AppManagerViewModel.shared.isActive = true
                    cameraModel.startSession()
                case .background:
                    AppManagerViewModel.shared.isActive = false
                case .inactive:
                    if AppManagerViewModel.shared.isActive == true {
                        cameraModel.startSession()
                    }
                @unknown default:
                    return
                }
            }
            .onAppear {
                cameraModel.startSession()
            }
            .onDisappear {
                cameraModel.session?.stopRunning()
            }
            .alert("The scanned QR Code is not an URL!", isPresented: $showingNoURLAlert) {
                Button("Dismiss") {
                    showingNoURLAlert = false
                    cameraModel.startSession()
                }
            }
            .fullScreenCover(isPresented: $showingInAppBrowser) {
                SafariViewWrapper(url: APIViewModel.shared.latestScannedURL!).ignoresSafeArea()
            }
            .onChange(of: showingInAppBrowser) { newValue in
                if newValue == true {
                    cameraModel.startSession()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(.white)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
