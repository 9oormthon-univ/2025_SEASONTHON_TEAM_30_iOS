//
//  PostDetailComment.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 디테일 페이지 댓글 모델
import Foundation

struct PostDetailComment: Identifiable, Equatable {
    let id: String
    let userimgUrl: String //유저 이미지 Url
    let userName: String //유저 닉네임
    let userTitle: String //유저 칭호
    let userTitleColor: String //유저 칭호 색깔
    let createdAt: String //작성 시간
    let content: String //댓글 내용
}

// 서버 응답 모델을 Post 모델로 매핑하기 위한 이니셜라이저
extension PostDetailComment {
    init(from data: GetPostDetailResponse.CommentsResponse) {
        self.id = data.commentId
        self.userimgUrl = data.userimgUrl
        self.userName = data.userName
        self.userTitle = data.userTitle
        self.userTitleColor = data.userTitleColor
        self.createdAt = data.createdAt
        self.content = data.content
    }
}

//MARK: - Mock 데이터
extension PostDetailComment {
    static let mockComments: [PostDetailComment] = [
        PostDetailComment(
            id: "1",
            userimgUrl: "https://picsum.photos/50?1",
            userName: "나다",
            userTitle: "성실꾼",
            userTitleColor: "#FFDC68",
            createdAt: "2025-08-29",
            content: "오늘 날씨가 정말 좋네요 저도 휴양을 떠나고 싶네요 ㅎㅎ!"
        ),
        PostDetailComment(
            id: "2",
            userimgUrl: "https://picsum.photos/50?2",
            userName: "마데",
            userTitle: "인기스타",
            userTitleColor: "#6A7BFF",
            createdAt: "2025-08-29",
            content: "긴 댓글 달아보기 긴 댓글 달아보기 긴 댓글 달아보기 긴 댓글 달아보기 긴 댓글 달아보기 긴 댓글 달아보기 긴 댓글 달아보기 긴 댓글 달아보기"
        ),
        PostDetailComment(
            id: "3",
            userimgUrl: "https://picsum.photos/50?3",
            userName: "구름",
            userTitle: "소확행러",
            userTitleColor: "#FF544E",
            createdAt: "2025-08-28",
            content: "여행 사진 공유합니다."
        ),
        PostDetailComment(
            id: "4",
            userimgUrl: "https://picsum.photos/50?4",
            userName: "유니브",
            userTitle: "새싹",
            userTitleColor: "#60CE38",
            createdAt: "2025-08-28",
            content: "오늘 만든 요리 사진!"
        ),
        PostDetailComment(
            id: "5",
            userimgUrl: "https://picsum.photos/50?5",
            userName: "아아아아",
            userTitle: "수다쟁이",
            userTitleColor: "#FF945A",
            createdAt: "2025-08-28",
            content: "책 추천해주세요."
        )
    ]
}
