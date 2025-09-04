//
//  SplashService.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스플레쉬 서비스
import Alamofire
import Foundation

// MARK: - SplashService Protocol
protocol SplashServiceProtocol {
    func getSplash(request: GetSplashRequest) async throws -> SplashUserSession
}

// MARK: - SplashService (실제 API 통신)
class SplashService: SplashServiceProtocol {
    // 스플레쉬 조회 요청
    func getSplash(request: GetSplashRequest) async throws -> SplashUserSession {
        let parameters: Parameters = [
            "refreshToken": request.refreshToken
        ]
        let response: GetSplashResponse = try await APIManager.shared.request("/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        let userSession = SplashUserSession(from: response)
        
        return userSession
    }
}

//MARK: - MockSplashService (테스트용)
class MockSplashService: SplashServiceProtocol {
    // 스플레쉬 조회 요청
    func getSplash(request: GetSplashRequest) async throws -> SplashUserSession {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        //자동 로그인 실패로 테스트 하려면
//        throw NSError(domain: "MockSplashError", code: 401, userInfo: [NSLocalizedDescriptionKey: "자동 로그인 실패"])
        return SplashUserSession.mock
    }
}
