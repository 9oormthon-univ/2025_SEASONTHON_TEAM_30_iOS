//
//  Post.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 홈 게시물 모델
import Foundation

struct Post: Identifiable, Equatable {
    let id: String
    let userimgUrl: String //유저 이미지 Url
    let userName: String //유저 닉네임
    let userTitle: String //유저 칭호
    let userTitleColor: String //유저 칭호 색깔
    let createdAt: String //작성 시간
    let content: String //내용
    let contentImgUrl: String //게시물 이미지 Url
    let likeCount: Int //좋아요 개수
    let isLiked: Bool //좋아요 눌렀는지
    let commentCount: Int //댓글 개수
}

// 서버 응답 모델을 Post 모델로 매핑하기 위한 이니셜라이저
extension Post {
    init(from data: GetHomeResponse.PostsResponse) {
        self.id = data.postId
        self.userimgUrl = data.userimgUrl
        self.userName = data.userName
        self.userTitle = data.userTitle
        self.userTitleColor = data.userTitleColor
        self.createdAt = data.createdAt
        self.content = data.content
        self.contentImgUrl = data.contentImgUrl
        self.likeCount = data.likeCount
        self.isLiked = data.isLiked
        self.commentCount = data.commentCount
    }
}


// MARK: - Mock 데이터
extension Post {
    static let mockPosts: [Post] = [
        Post(id: "1", userimgUrl: "https://picsum.photos/50?1", userName: "나다", userTitle: "성실꾼", userTitleColor: "#FFDC68", createdAt: "2025-08-29", content: "오늘 날씨가 정말 좋네요!", contentImgUrl: "https://picsum.photos/200?1", likeCount: 12, isLiked: false, commentCount: 3),
        Post(id: "2", userimgUrl: "https://picsum.photos/50?2", userName: "마데", userTitle: "인기스타", userTitleColor: "#6A7BFF", createdAt: "2025-08-29", content: "새로운 프로젝트를 시작했어요.", contentImgUrl: "https://picsum.photos/200?2", likeCount: 34, isLiked: true, commentCount: 5),
        Post(id: "3", userimgUrl: "https://picsum.photos/50?3", userName: "구름", userTitle: "소확행러", userTitleColor: "#FF544E", createdAt: "2025-08-28", content: "여행 사진 공유합니다.", contentImgUrl: "https://picsum.photos/200?3", likeCount: 45, isLiked: false, commentCount: 7),
        Post(id: "4", userimgUrl: "https://picsum.photos/50?4", userName: "유니브", userTitle: "새싹", userTitleColor: "#60CE38", createdAt: "2025-08-28", content: "오늘 만든 요리 사진!", contentImgUrl: "https://picsum.photos/200?4", likeCount: 22, isLiked: true, commentCount: 4),
        Post(id: "5", userimgUrl: "https://picsum.photos/50?5", userName: "아아아아", userTitle: "수다쟁이", userTitleColor: "#FF945A", createdAt: "2025-08-28", content: "책 추천해주세요.", contentImgUrl: "https://picsum.photos/200?5", likeCount: 18, isLiked: false, commentCount: 2),
        Post(id: "6", userimgUrl: "https://picsum.photos/50?6", userName: "Frank", userTitle: "성실꾼", userTitleColor: "#FFDC68", createdAt: "2025-08-28", content: "오늘 운동 기록 공유합니다.", contentImgUrl: "https://picsum.photos/200?6", likeCount: 27, isLiked: true, commentCount: 6),
        Post(id: "7", userimgUrl: "https://picsum.photos/50?7", userName: "Grace", userTitle: "인기스타", userTitleColor: "#6A7BFF", createdAt: "2025-08-28", content: "맛집 리뷰 남겨요.", contentImgUrl: "https://picsum.photos/200?7", likeCount: 40, isLiked: false, commentCount: 9),
        Post(id: "8", userimgUrl: "https://picsum.photos/50?8", userName: "Henry", userTitle: "소확행러", userTitleColor: "#FF544E", createdAt: "2025-08-28", content: "오늘 찍은 사진 공유합니다.", contentImgUrl: "https://picsum.photos/200?8", likeCount: 30, isLiked: true, commentCount: 5),
        Post(id: "9", userimgUrl: "https://picsum.photos/50?9", userName: "Ivy", userTitle: "새싹", userTitleColor: "#60CE38", createdAt: "2025-08-28", content: "드디어 완성했어요!", contentImgUrl: "https://picsum.photos/200?9", likeCount: 15, isLiked: false, commentCount: 1),
        Post(id: "10", userimgUrl: "https://picsum.photos/50?10", userName: "Jack", userTitle: "수다쟁이", userTitleColor: "#FF945A", createdAt: "2025-08-28", content: "오늘 하루 일과 공유.", contentImgUrl: "https://picsum.photos/200?10", likeCount: 25, isLiked: true, commentCount: 3),
        Post(id: "11", userimgUrl: "https://picsum.photos/50?11", userName: "Karen", userTitle: "성실꾼", userTitleColor: "#FFDC68", createdAt: "2025-08-28", content: "좋은 음악 발견했어요.", contentImgUrl: "https://picsum.photos/200?11", likeCount: 50, isLiked: false, commentCount: 8),
        Post(id: "12", userimgUrl: "https://picsum.photos/50?12", userName: "Leo", userTitle: "인기스타", userTitleColor: "#6A7BFF", createdAt: "2025-08-28", content: "오늘 기분이 좋아요.", contentImgUrl: "https://picsum.photos/200?12", likeCount: 33, isLiked: true, commentCount: 4),
        Post(id: "13", userimgUrl: "https://picsum.photos/50?13", userName: "Mia", userTitle: "소확행러", userTitleColor: "#FF544E", createdAt: "2025-08-28", content: "새로운 앱 개발 시작!", contentImgUrl: "https://picsum.photos/200?13", likeCount: 20, isLiked: false, commentCount: 2),
        Post(id: "14", userimgUrl: "https://picsum.photos/50?14", userName: "Nick", userTitle: "새싹", userTitleColor: "#60CE38", createdAt: "2025-08-28", content: "사진 찍는 연습 중이에요.", contentImgUrl: "https://picsum.photos/200?14", likeCount: 28, isLiked: true, commentCount: 5),
        Post(id: "15", userimgUrl: "https://picsum.photos/50?15", userName: "Olivia", userTitle: "수다쟁이", userTitleColor: "#FF945A", createdAt: "2025-08-28", content: "새로운 커피 맛집 탐방!", contentImgUrl: "https://picsum.photos/200?15", likeCount: 35, isLiked: false, commentCount: 6),
        Post(id: "16", userimgUrl: "https://picsum.photos/50?16", userName: "Paul", userTitle: "성실꾼", userTitleColor: "#FFDC68", createdAt: "2025-08-28", content: "오늘 운동 목표 달성!", contentImgUrl: "https://picsum.photos/200?16", likeCount: 45, isLiked: true, commentCount: 7),
        Post(id: "17", userimgUrl: "https://picsum.photos/50?17", userName: "Quinn", userTitle: "인기스타", userTitleColor: "#6A7BFF", createdAt: "2025-08-28", content: "맛있는 점심 먹었어요.", contentImgUrl: "https://picsum.photos/200?17", likeCount: 12, isLiked: false, commentCount: 1),
        Post(id: "18", userimgUrl: "https://picsum.photos/50?18", userName: "Rachel", userTitle: "소확행러", userTitleColor: "#FF544E", createdAt: "2025-08-28", content: "오늘 하루 리뷰!", contentImgUrl: "https://picsum.photos/200?18", likeCount: 38, isLiked: true, commentCount: 4),
        Post(id: "19", userimgUrl: "https://picsum.photos/50?19", userName: "Sam", userTitle: "새싹", userTitleColor: "#60CE38", createdAt: "2025-08-28", content: "새로운 취미 시작했습니다.", contentImgUrl: "https://picsum.photos/200?19", likeCount: 21, isLiked: false, commentCount: 3),
        Post(id: "20", userimgUrl: "https://picsum.photos/50?20", userName: "Tina", userTitle: "수다쟁이", userTitleColor: "#FF945A", createdAt: "2025-08-28", content: "오늘 하루 마무리!", contentImgUrl: "https://picsum.photos/200?20", likeCount: 42, isLiked: true, commentCount: 6)
    ]
}
