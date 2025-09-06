//
//  CalendarService.swift
//  MyDays
//
//  Created by 양재현 on 8/31/25.
//

//MARK: - 캘린더 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - CalendarService Protocol
protocol CalendarServiceProtocol {
    func getCalendarWeeks() async throws -> [DayContent]
    func postlike(postId: String) async throws -> EmptyData
}

// MARK: - CalendarService (실제 API 통신)
class CalendarService: CalendarServiceProtocol {
    // 주간 캘린더 뷰 조회 요청
    func getCalendarWeeks() async throws -> [DayContent] {

        let response: GetWeeksResponse = try await APIManager.shared.request("/users/calendar/week", method: .get)
        
        let dayContents = response.dayContents.map { DayContent(from: $0) }
        
        return dayContents
    }
    
    // 좋아요 기능
    func postlike(postId: String) async throws -> EmptyData {
        let parameters: Parameters = [
            "postId": postId
        ]
        
        let response: EmptyData = try await APIManager.shared.request("/posts/like", method: .post, parameters: parameters, encoding: JSONEncoding.default)
        
        return response
    }
}

//MARK: - MockHomeService (테스트용)
class MockCalendarService: CalendarServiceProtocol {
    // 주간 캘린더 뷰 조회 요청
    func getCalendarWeeks() async throws -> [DayContent] {
        return DayContent.mockMissions
    }
    
    // 좋아요 기능
    func postlike(postId: String) async throws -> EmptyData {
        return EmptyData()
    }
}
