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
}

// MARK: - CalendarService (실제 API 통신)
class CalendarService: CalendarServiceProtocol {
    // 캘린더 뷰 조회 요청
    func getCalendarWeeks() async throws -> [DayContent] {

        let response: GetWeeksResponse = try await APIManager.shared.request("/", method: .get)
        
        let dayContents = response.dayContents.map { DayContent(from: $0) }
        
        return dayContents
    }
}

//MARK: - MockHomeService (테스트용)
class MockCalendarService: CalendarServiceProtocol {
    // 캘린더 뷰 조회 요청
    func getCalendarWeeks() async throws -> [DayContent] {
        return DayContent.mockMissions
    }
}
