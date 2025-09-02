//
//  LoginServerModel.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 로그인 서버 모델
import Foundation

//카카오 로그인 요청 (백엔드에게)
struct KakaLoginRequest: Decodable {
    let accessToken: String //카카오 토큰
    let refreshToken: String //카카오 토큰
}

//카카오 로그인 응답 (백엔드한테서)
struct KakaLoginResponse: Decodable {
    let accessToken: String //백엔드 토큰
    let refreshToken: String //백엔드  토큰
    let isNewUser: Bool //닉네임 설정했는지 여부
}
