//
//  SplashView.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스플래쉬 뷰
import SwiftUI

struct SplashView: View {
    @StateObject var vm = SplashViewModel()
    @EnvironmentObject var nav: NavigationManager
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            Image("logo.splash")
            
            Text("매일 한 번, 가장 나다운 순간")
                .font(.t2())
                .foregroundColor(.white)
                .padding(.top, 45)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            Image("mydays.splash")
                .padding(.bottom, 10)
        }
        .background(.mdNavi1)
        
        //자동 로그인 성공 시 감지해서 메인화면으로 이동
        .onChange(of: vm.isSwitchMain) { _, newValue in
            if newValue {
                print("메인 화면으로 전환")
                appState.currentView = .main
                vm.isSwitchMain = false // 플래그 리셋 (중복 이동 방지)
            }
        }
        //자동 로그인 실패 시 감지해서 로그인화면으로 이동
        .onChange(of: vm.isSwitchLogin) { _, newValue in
            if newValue {
                print("로그인 화면으로 전환")
                appState.currentView = .login
                vm.isSwitchLogin = false // 플래그 리셋 (중복 이동 방지)
            }
        }
        //스플레쉬 뷰 조회시
        .onAppear {
            vm.getSplash()
        }
    }
}

#Preview {
    SplashView()
}
