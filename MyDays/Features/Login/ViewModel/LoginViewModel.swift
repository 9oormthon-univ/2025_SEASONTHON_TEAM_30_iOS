//
//  LoginViewModel.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 로그인 뷰모델 입니다.
import Foundation

@MainActor
class LoginViewModel: ObservableObject {
    @Published var isNewUser: Bool = false //닉네임 설정 페이지로 이동해야하는지
    @Published var isSwitchMain: Bool = false //홈 화면으로 전환할지 (로그인 성공시)
    
    private let loginService = MockLoginService() //의존성 주입 (Real or Mock)
    
    //MARK: - 카카오 로그인 시도
    func kakaoLogin() {
        Task {
            //TODO: 여기 엑세스, 리프레쉬 ""로 되있는거 카카오에서 받아온 토큰을 넣어주기
            let userSession = try await loginService.kakaoLogin(request: KakaLoginRequest(accessToken: "", refreshToken: ""))
            
            //keyChain에 백에서 받아온 액세스, 리프레쉬 토큰 저장
            KeychainHelper.save(key: "accessToken", value: userSession.accessToken)
            KeychainHelper.save(key: "refreshToken", value: userSession.refreshToken)
            
//            // 불러오기 참고용 (엑세스는 APIManager 헤더에서 쓰면 될 듯)
//            if let accessToken = KeychainHelper.load(key: "accessToken") {
//                print("AccessToken: \(accessToken)")
//            }
//            // 리프레쉬는 스플래쉬 api에서 활용하면 될듯
//            if let refreshToken = KeychainHelper.load(key: "refreshToken") {
//                print("refreshToken: \(refreshToken)")
//            }
            
            self.isNewUser = userSession.isNewUser
            //기존 유저면 홈으로 이동 
            if self.isNewUser == false {
                self.isSwitchMain = true
            }
        }
    }
}
