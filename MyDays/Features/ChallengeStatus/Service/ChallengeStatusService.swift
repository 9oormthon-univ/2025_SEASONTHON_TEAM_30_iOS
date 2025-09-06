//
//  ChallengeStatusService.swift
//  MyDays
//
//  Created by Apple on 9/5/25.
//

//MARK: - 챌린지 상태 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - ChallengeStatusService Protocol
// 실제 서비스와 Mock 서비스 모두 이 프로토콜을 따릅니다.
protocol ChallengeStatusServiceProtocol {
    func getChallengeStatus() async throws -> ChallengeStatusComponent
    func getUserTitles() async throws -> [TitleComponent.Title]
    func updateActiveTitle(titleId: String) async throws
    
}

// MARK: - ChallengeStatusService (실제 API 통신)
class ChallengeStatusService: ChallengeStatusServiceProtocol {
    // 챌린지 상태 뷰 조회 api
    func getChallengeStatus() async throws -> ChallengeStatusComponent {
            let response: GetChallengeStatusResponse = try await APIManager.shared.request("/users/me", method: .get)
            return ChallengeStatusComponent(from: response)
    }
    
    // 보유 칭호 조회
    func getUserTitles() async throws -> [TitleComponent.Title]{
        let response: GetUserTitlesResponse = try await APIManager.shared.request(
                "/users/titles",
                method: .get
        )
        
        let component = TitleComponent(from: response)
        return component.titles
        

    }
    
    // 대표 칭호 변경
    func updateActiveTitle(titleId: String) async throws {
        let requestBody = UpdateActiveTitleRequest(titleId: titleId)
            
        // 반환 값이 없을 경우의 요청
        _ = try await APIManager.shared.request(
                "/users/active-title",   // 명세서에 나온 endpoint
                method: .put,
                parameters: requestBody.toDictionary(),
                encoding: JSONEncoding.default
            ) as EmptyResponse
    }
    
    
    
}

//MARK: - MockChallengeStatusService (테스트용)
class MockChallengeStatusService: ChallengeStatusServiceProtocol {
    // 챌린지 상태 뷰 조회 api
    func getChallengeStatus() async throws -> ChallengeStatusComponent {
        return ChallengeStatusComponent.mock // <-- 저희가 모델에서 만든 가짜 데이터에요
    }
    func getUserTitles() async throws -> [TitleComponent.Title] {
            return [
                .init(titleId: "1", title: "열정왕", titleColor: "#FF0000"),
                .init(titleId: "2", title: "꾸준러", titleColor: "#00FF00"),
                .init(titleId: "3", title: "성실맨", titleColor: "#0000FF")
            ]
    }
    
    func updateActiveTitle(titleId: String) async throws {
            // 테스트 환경에서는 무시
            print("\(titleId)로 칭호 변경 요청 (Mock)")
    }
}
