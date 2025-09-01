//
//  MonthCalendarPost.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

//MARK: - 월 달력에 포스트 모델 (원으로 보여줄거)
import Foundation

struct MonthCalendarPost {
    let postId: String //게시물 pk
    let imageUrl: String //이미지 url
    let date: Date //날짜
}

//서버 모델 매핑용 이니셜라이저
extension MonthCalendarPost {
    init(from data: GetCalendarPostsResponse.MonthCalendarPostResponse) {
        self.postId = data.postId
        self.imageUrl = data.imageUrl
        self.date = data.date
    }
}

// MARK: - Mock Data
extension MonthCalendarPost {
    static let mockData: [MonthCalendarPost] = [
        MonthCalendarPost(
            postId: "1",
            imageUrl: "https://picsum.photos/200/200?random=1",
            date: ISO8601DateFormatter().date(from: "2025-09-01T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "2",
            imageUrl: "https://picsum.photos/200/200?random=2",
            date: ISO8601DateFormatter().date(from: "2025-09-03T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "3",
            imageUrl: "https://picsum.photos/200/200?random=3",
            date: ISO8601DateFormatter().date(from: "2025-09-08T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "4",
            imageUrl: "https://picsum.photos/200/200?random=4",
            date: ISO8601DateFormatter().date(from: "2025-09-15T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "5",
            imageUrl: "https://picsum.photos/200/200?random=5",
            date: ISO8601DateFormatter().date(from: "2025-09-21T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "6",
            imageUrl: "https://picsum.photos/200/200?random=3",
            date: ISO8601DateFormatter().date(from: "2025-08-08T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "7",
            imageUrl: "https://picsum.photos/200/200?random=4",
            date: ISO8601DateFormatter().date(from: "2025-07-15T00:00:00Z")!
        ),
        MonthCalendarPost(
            postId: "8",
            imageUrl: "https://picsum.photos/200/200?random=5",
            date: ISO8601DateFormatter().date(from: "2025-06-21T00:00:00Z")!
        )
    ]
}
