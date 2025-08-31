//
//  CalendarMission.swift
//  MyDays
//
//  Created by 양재현 on 8/31/25.
//

//MARK: - 캘린더 화면에서 미션 모델
import Foundation

struct DayContent {
    let day: Int //당일 Day (ex. Day 1)
    let date: String //날짜 (ex. 9월 2일 화요일)
    let text: String //오늘의 미션 내용 (ex. 나의 장점 3가지는 무엇입니까 ?)
    
    let post: Post?
}

//서버 모델 매핑용 이니셜라이저
extension DayContent {
    init(from data: GetWeeksResponse.DayContentsResponse) {
        self.day = data.day
        self.date = data.date
        self.text = data.missionText
        
        self.post = Post(from: data) //이거 참 좋네
    }
}

// MARK: - Mock Data
extension DayContent {
    static let mockMissions: [DayContent] = [
        DayContent(
            day: 31,
            date: "8월 31일 일요일",
            text: "오늘의 날씨가 어떤지 표현해보세요!",
            post:   Post(id: "1", userimgUrl: "https://picsum.photos/50?1", userName: "나다", userTitle: "성실꾼", userTitleColor: "#FFDC68", createdAt: "2025-08-31", content: "오늘 날씨가 정말 좋네요!", contentImgUrl: "https://picsum.photos/200?1", likeCount: 12, isLiked: false, commentCount: 3)
        ),
        DayContent(
            day: 1,
            date: "9월 1일 월요일",
            text: "최대한 긴 글을 적으세요 최대한....",
            post:  Post(id: "2", userimgUrl: "https://picsum.photos/50?2", userName: "마데", userTitle: "인기스타", userTitleColor: "#6A7BFF", createdAt: "2025-09-01", content: "긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기 긴 글 적어보기긴 글 적어보기긴 글 적어보기", contentImgUrl: "https://picsum.photos/200?2", likeCount: 34, isLiked: true, commentCount: 5)
        ),
        DayContent(
            day: 2,
            date: "9월 2일 화요일",
            text: "자신이 맘에 드는 사진 1장을 공유하세요",
            post:  Post(id: "3", userimgUrl: "https://picsum.photos/50?3", userName: "구름", userTitle: "소확행러", userTitleColor: "#FF544E", createdAt: "2025-09-02", content: "여행 사진 공유합니다.", contentImgUrl: "https://picsum.photos/200?3", likeCount: 45, isLiked: false, commentCount: 7),
        ),
        DayContent(
            day: 3,
            date: "9월 3일 수요일",
            text: "자신의 요리실력을 뽐내보세요!",
            post:  Post(id: "4", userimgUrl: "https://picsum.photos/50?4", userName: "유니브", userTitle: "새싹", userTitleColor: "#60CE38", createdAt: "2025-09-03", content: "오늘 만든 요리 사진!", contentImgUrl: "https://picsum.photos/200?4", likeCount: 22, isLiked: true, commentCount: 4)
        ),
        DayContent(
            day: 4,
            date: "9월 4일 목요일",
            text: "오늘의 미션은 ~ 미정",
            post: /*Post(id: "5", userimgUrl: "https://picsum.photos/50?5", userName: "아아아아", userTitle: "수다쟁이", userTitleColor: "#FF945A", createdAt: "2025-09-04", content: "책 추천해주세요.", contentImgUrl: "https://picsum.photos/200?5", likeCount: 18, isLiked: false, commentCount: 2)
                   */ nil
        ),
        DayContent(
            day: 5,
            date: "9월 5일 금요일",
            text: "어떤 운동이든 해보세요",
            post: Post(id: "6", userimgUrl: "https://picsum.photos/50?6", userName: "Frank", userTitle: "성실꾼", userTitleColor: "#FFDC68", createdAt: "2025-09-05", content: "오늘 운동 기록 공유합니다.", contentImgUrl: "https://picsum.photos/200?6", likeCount: 27, isLiked: true, commentCount: 6)
        ),
        DayContent(
            day: 6,
            date: "9월 6일 토요일",
            text: "오늘의 하루를 남겨보세요",
            post: Post(id: "7", userimgUrl: "https://picsum.photos/50?7", userName: "Grace", userTitle: "인기스타", userTitleColor: "#6A7BFF", createdAt: "2025-09-06", content: "맛집 리뷰 남겨요.", contentImgUrl: "https://picsum.photos/200?7", likeCount: 40, isLiked: false, commentCount: 9)
        )
    ]
}
