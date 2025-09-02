//
//  MyDaysApp.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

import SwiftUI

@main
struct MyDaysApp: App {
    @StateObject private var appState = AppState()
    var body: some Scene {
        WindowGroup {
            switch appState.currentView {
            case .splash:
                SplashView()
            case .login:
                LoginView()
            case .main:
                TabBarView()
            }
        }.environmentObject(appState)
    }
}

