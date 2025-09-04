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
            Image("logo.splash")
            
            Text("매일 한 번, 가장 나다운 순간")
                .font(.t1())
                .foregroundColor(.white)
                .padding(.top, 45)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .bottom) {
            Button(action: { vm.kakaoLogin() }) {
                LoginButton()
                    .padding(.horizontal, 40)
            }
        }
        .background(.mdSurf2)
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
//TODO: 로그인 버튼 제대로 만들기 (디자인 나오면)
struct LoginButton: View {
    var body: some View {
        Text("카카오 로그인")
//            .font(.l1())
            .foregroundColor(.black)
            .padding(.vertical, 11)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Image("back")
                    .padding(.leading, 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(.yellow)
            )
    }
}

#Preview {
    LoginView()
}
