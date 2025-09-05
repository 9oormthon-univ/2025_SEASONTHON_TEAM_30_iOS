//
//  LoginViewModel.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 로그인 뷰모델 입니다.
import Foundation
import KakaoSDKUser
import KakaoSDKAuth

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isNewUser: Bool = false //닉네임 설정 페이지로 이동해야하는지
    @Published var isSwitchMain: Bool = false //홈 화면으로 전환할지 (로그인 성공시)
    @Published var isLoading: Bool = false //로그인 로딩
    
    private let loginService = MockLoginService() //의존성 주입 (Real or Mock)
    
    //MARK: - 카카오 로그인 시도
    func kakaoLogin() {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    guard let token = oauthToken else {
                        return
                    }
                    print("카카오톡 로그인 성공, 토큰:", token)
                    self.sendTokenToServer(oauthToken: token)
                }
            }
        } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    guard let token = oauthToken else {
                        return
                    }
                    print("카카오계정 로그인 성공, 토큰:", token)
                    self.sendTokenToServer(oauthToken: token)
                }
            }
        }
    }
    
    // MARK: - 서버로 토큰 전송 및 Keychain 저장
    private func sendTokenToServer(oauthToken: OAuthToken) {
        self.isLoading = true
        Task {
            do {
                //서버로 access, refresh 토큰 전송
                let userSession = try await loginService.kakaoLogin(request: KakaLoginRequest(accessToken: oauthToken.accessToken, refreshToken: oauthToken.refreshToken))
                
                //keyChain에 백에서 받아온 액세스, 리프레쉬 토큰 저장
                KeychainHelper.save(key: "accessToken", value: userSession.accessToken)
                KeychainHelper.save(key: "refreshToken", value: userSession.refreshToken)
                
                self.isNewUser = userSession.isNewUser
                //기존 유저면 홈으로 이동
                if self.isNewUser == false {
                    self.isSwitchMain = true
                }
            }
            catch {
                print("‼️서버와 카카오 로그인 통신 오류")
                print(error)
            }
            self.isLoading = false
        }
    }
    
}

