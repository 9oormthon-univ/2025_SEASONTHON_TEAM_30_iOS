//
//  LoginService.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 로그인 서비스
import Alamofire
import Foundation

// MARK: - LoginService Protocol
protocol LoginServiceeProtocol {
    func kakaoLogin(request: KakaLoginRequest) async throws -> UserSession
}

// MARK: - LoginService (실제 API 통신)
class LoginService: LoginServiceeProtocol {
    // 카카오 로그인 요청
    func kakaoLogin(request: KakaLoginRequest) async throws -> UserSession {
        let parameters: Parameters = [
            "accessToken": request.accessToken, //카카오 토큰
            "refreshToken": request.refreshToken //카카오 토큰
        ]
        let response: KakaLoginResponse = try await APIManager.shared.request("/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        let userSession = UserSession(from: response)
        
        return userSession
    }
}

//MARK: - MockLoginService (테스트용)
class MockLoginService: LoginServiceeProtocol {
    // 카카오 로그인 요청
    func kakaoLogin(request: KakaLoginRequest) async throws -> UserSession {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        return UserSession.mock
    }
}
