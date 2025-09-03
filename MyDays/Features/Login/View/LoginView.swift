//
//  LoginView.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 로그인 뷰
import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    @EnvironmentObject var nav: NavigationManager
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(spacing: 0) {
            Text("로그인 뷰")
            
            Button(action: { vm.kakaoLogin() }) {
                Text("카카오 로그인 버튼")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mdSurf3)
        //작성 완료 감지해서 디테일 페이지로 이동
        .onChange(of: vm.isNewUser) { _, newValue in
            if newValue {
                nav.push(AppRoute.setNickname) //닉네임 설정 페이지로 이동시키기
                vm.isNewUser = false // 플래그 리셋 (중복 이동 방지)
            }
        }
        //로그인 성공 시 감지해서 홈 화면으로 전환
        .onChange(of: vm.isSwitchMain) { _, newValue in
            if newValue {
                print("메인 화면으로 전환")
                appState.currentView = .main
                vm.isSwitchMain = false // 플래그 리셋 (중복 이동 방지)
            }
        }
    }
}

#Preview {
    LoginView()
}
