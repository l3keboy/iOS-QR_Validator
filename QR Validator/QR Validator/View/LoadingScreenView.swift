//
//  ContentView.swift
//  QR Validator
//
//  Created by Luke Hendriks on 16/07/2022.
//

import SwiftUI

struct LoadingScreenView: View {
    @State private var showingLoadingScreen = true
    
    var body: some View {
        ZStack {
            ZStack {
                Color("PrimaryColor").ignoresSafeArea()
                
                Text("QR Validator")
                    .font(.system(size: 56))
                    .foregroundColor(.white)
            }.task {
                await delayLoadingScreen()
            }
            if showingLoadingScreen != true {
                MainView()
            }
        }
    }
    
    func delayLoadingScreen() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        withAnimation {
            showingLoadingScreen = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreenView()
    }
}
