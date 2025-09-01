//
//  MonthCalendarService.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

//MARK: - 월 단위 달력 화면 서버 연동 로직
import Alamofire
import Foundation

// MARK: - MonthCalendarService Protocol
protocol MonthCalendarServiceProtocol {
    func getCalendarPosts() async throws -> (Date, [MonthCalendarPost]) //(유저 가입일, 게시물 리스트)
}

// MARK: - MonthCalendarService (실제 API 통신)
class MonthCalendarService: MonthCalendarServiceProtocol {
    // 월 단위 달력 뷰 조회 요청
    func getCalendarPosts() async throws -> (Date, [MonthCalendarPost]) {
        let response: GetCalendarPostsResponse = try await APIManager.shared.request("/", method: .get)
        
        let posts = response.posts.map { MonthCalendarPost(from: $0) }
        let userCreatedAt = response.userCreatedAt
        
        return (userCreatedAt, posts)
    }
}

//MARK: - MockMonthCalendarService (테스트용)
class MockMonthCalendarService: MonthCalendarServiceProtocol {
    // 월 단위 달력 뷰 조회 요청
    func getCalendarPosts() async throws -> (Date, [MonthCalendarPost]) {
        // 유저 생성일 지정 (예: 2024년 1월 15일)
        let dateFormatter = ISO8601DateFormatter()
        let userCreatedAt = dateFormatter.date(from: "2025-07-15T00:00:00Z") ?? Date()
        
        return (userCreatedAt, MonthCalendarPost.mockData)
    }
}
