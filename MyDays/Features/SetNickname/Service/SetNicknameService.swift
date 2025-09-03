//
//  SetNicknameService.swift
//  MyDays
//
//  Created by 양재현 on 9/3/25.
//

//MARK: - 닉네임 정하기 서비스
import Alamofire
import Foundation

// MARK: - SetNicknameService Protocol
protocol SetNicknameServiceProtocol {
    func setNickname(request: PostNicknameRequest) async throws -> EmptyData
}

// MARK: - SetNicknameService (실제 API 통신)
class SetNicknameService: SetNicknameServiceProtocol {
    // 닉네임 등록 요청
    func setNickname(request: PostNicknameRequest) async throws -> EmptyData {
        let parameters: Parameters = [
            "nickName": request.nickName
        ]
        let response: EmptyData = try await APIManager.shared.request("/", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response
    }
}

//MARK: - MockSetNicknameService (테스트용)
class MockSetNicknameService: SetNicknameServiceProtocol {
    // 닉네임 등록 요청
    func setNickname(request: PostNicknameRequest) async throws -> EmptyData {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return EmptyData()
    }
}
