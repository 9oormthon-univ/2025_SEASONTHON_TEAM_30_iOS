//
//  MyDaysApp.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

import SwiftUI
import KakaoSDKAuth

@main
struct MyDaysApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appState = AppState()
    @StateObject var navigationManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationManager.path) {
                Group {
                    switch appState.currentView {
                    case .splash:
                        SplashView()
                    case .login:
                        LoginView()
                    case .main:
                        TabBarView()
                    }
                }
                //네비게이션 목적지
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .setNickname:
                        SetNicknameView()
                        
                    case .postDetail(let postId):
                        PostDetailView(postId: postId)
                        
                    case .write:
                        WriteView()
                        
                    case .setting:
                        Color.black //TODO: 추후 세팅페이지로 변경
                        
                    case .completedLogin(let nickName):
                        CompletedLoginView(nickName: nickName)
                    }
                }
            }
            //카카오 로그인 딥링크용
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
            .environmentObject(appState) //루트 뷰 상태 하위뷰에 주입
            .environmentObject(navigationManager)  //네비게이션 매니저 하위뷰에 주입
        }
    }
}

