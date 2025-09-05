//
//  LoginView.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 소셜 로그인 뷰
import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    @EnvironmentObject var nav: NavigationManager
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //로고
            Image("logo.login")
                .padding(.horizontal, 46)
                .padding(.top, 102)
            
            Text("매일 한 번\n가장 나다운 순간을 경험해보세요")
                .font(.t2())
                .foregroundColor(.white)
                .padding(.horizontal, 46)
                .padding(.top, 30)
            
            Spacer()
            
            //로그인 버튼 위 캐릭터들
            HStack {
                Spacer()
                Image("char.login")
                    .resizable()
                    .frame(width: 230, height: 134)
            }
            .padding(.trailing, 24)
            
            //카카오 로그인 버튼
            Button(action: { vm.kakaoLogin() }) {
                LoginButton()
                    .padding(.horizontal, 24)
            }
            .padding(.top, 11)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mdNavi1)
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
        Text("카카오로 시작하기")
            .font(.b2Bold())
            .foregroundColor(Color(hex: "000000", alpha: 0.85))
            .padding(.vertical, 11)
            .frame(maxWidth: .infinity)
            .overlay(alignment: .leading) {
                Image("kakao.logo")
                    .padding(.leading, 14)
            }
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color(hex: "FEE500"))
            )
    }
}

#Preview {
    LoginView()
}
