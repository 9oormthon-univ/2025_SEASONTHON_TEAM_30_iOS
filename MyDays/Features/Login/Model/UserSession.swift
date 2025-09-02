//
//  UserSession.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 유저 세션 모델
import Foundation

struct UserSession {
    let accessToken: String //백엔드 토큰
    let refreshToken: String //백엔드  토큰
    let isNewUser: Bool //닉네임 설정 했는지
}

// 서버 응답 모델을 매핑하기 위한 이니셜라이저
extension UserSession {
    init(from data: KakaLoginResponse) {
        self.accessToken = data.accessToken
        self.refreshToken = data.refreshToken
        self.isNewUser = data.isNewUser
    }
}


// MARK: - Mock 데이터
extension UserSession {
    static let mock: UserSession = UserSession(
        accessToken: "asdfasdf1234",
        refreshToken: "qwerqwer1234",
        isNewUser: true
    )
}
