//
//  SplashUserSession.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스플래쉬 유저 세션 모델
import Foundation

struct SplashUserSession {
    let accessToken: String //백엔드 토큰
    let refreshToken: String //백엔드 토큰
}

// 서버 응답 모델을 매핑하기 위한 이니셜라이저
extension SplashUserSession {
    init(from data: GetSplashResponse) {
        self.accessToken = data.accessToken
        self.refreshToken = data.refreshToken
    }
}


// MARK: - Mock 데이터
extension SplashUserSession {
    static let mock: SplashUserSession = SplashUserSession(
        accessToken: "hihihihihi",
        refreshToken: "helloworld"
    )
}
