//
//  SplashViewModel.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스플래쉬 뷰모델 입니다.
import Foundation

@MainActor
class SplashViewModel: ObservableObject {
    @Published var isSwitchLogin: Bool = false //로그인 화면으로 전환할지
    @Published var isSwitchMain: Bool = false //홈 화면으로 전환할지 (자동 로그인 성공시)
    
    private let splashService = MockSplashService() //의존성 주입 (Real or Mock)
    
    //MARK: - 스플레쉬 뷰 조회
    func getSplash() {
        Task {
           //스플레쉬 자동로그인 성공시
            do {
                //키체인에서 refreshToken 가져와서 요청 (but, nil일수도 있음)
                let userSession = try await splashService.getSplash(request: GetSplashRequest(refreshToken: KeychainHelper.load(key: "refreshToken") ))
                
                //keyChain에 백에서 받아온 액세스, 리프레쉬 토큰 저장
                KeychainHelper.save(key: "accessToken", value: userSession.accessToken)
                KeychainHelper.save(key: "refreshToken", value: userSession.refreshToken)
                
                // 불러오기 참고용 (엑세스는 APIManager 헤더에서 쓰면 될 듯)
                if let accessToken = KeychainHelper.load(key: "accessToken") {
                    print("AccessToken: \(accessToken)")
                }
                // 리프레쉬는 스플래쉬 api에서 활용하면 될듯
                if let refreshToken = KeychainHelper.load(key: "refreshToken") {
                    print("refreshToken: \(refreshToken)")
                }
                
                self.isSwitchMain = true //메인 화면으로 전환
            }
            //스플레쉬 자동로그인 실패시
            catch {
                self.isSwitchLogin = true //로그인 화면으로 전환
            }
        }
    }
}
