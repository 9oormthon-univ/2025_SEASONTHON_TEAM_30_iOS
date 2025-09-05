//
//  WriteService.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 작성화면 서버와 통신 로직
import Alamofire
import Foundation

// MARK: - WriteService Protocol
// 실제 서비스와 Mock 서비스 모두 이 프로토콜을 따릅니다.
protocol WriteServiceProtocol {
    func getWritePage() async throws -> WriteMission
    func postMission(request: PostMissionRequest) async throws -> String //PostId 리스폰
}

// MARK: - WriteService (실제 API 통신)
// WriteServiceProtocol을 채택하여 실제 서버와 통신하는 역할을 합니다.
class WriteService: WriteServiceProtocol {
    //작성 페이지 get 요청
    func getWritePage() async throws -> WriteMission {
        let response: GetWritePageResponse = try await APIManager.shared.request("/posts/mission", method: .get)
        let mission = WriteMission(from: response)
        
        return mission
    }
    
    //게시물(미션) 작성
    func postMission(request: PostMissionRequest) async throws -> String {
        let parameters: Parameters = [
            "content": request.content,
            "base64Img": request.base64Img
        ]
        let response: String = try await APIManager.shared.request("/posts", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response //postID임
    }
}

//MARK: - MockWriteService (테스트용)
class MockWriteService: WriteServiceProtocol {
    //작성 페이지 get 요청
    func getWritePage() async throws -> WriteMission {
//        try await Task.sleep(nanoseconds: 1_000_000_000)
        return WriteMission.mock
    }
    
    //게시물(미션) 작성
    func postMission(request: PostMissionRequest) async throws -> String {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        return "post1234"
    }
}


