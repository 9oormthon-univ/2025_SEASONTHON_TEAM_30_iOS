//
//  ChallengeStatusComponent.swift
//  MyDays
//
//  Created by Apple on 9/4/25.
//

import Foundation

struct ChallengeStatusComponent {
    let nickName: String
    let growthMessage: String
    let isBubbleVisible: Bool
    let userTitle: String
    let userTitleColor: String
    let progress: Double
    let imageUrl: String
    let totalChallengeCount: Int
    let daysCount: Int
    let isCompleteMission: Bool
    
    /* 아래에 Mock Data가 있어서 필요 없음
    // Mock 데이터 생성을 위한 이니셜라이저
    init(nickName: String, growthMessage: String, userTitle: String, userTitleColor: String, progress: Int, imageUrl: String, totalChallengeCount: Int, daysCount: Int, bubbleVisible: Bool, completeMission: Bool) {
        self.nickName = nickName
        self.growthMessage = growthMessage
        self.userTitle = userTitle
        self.userTitleColor = userTitleColor
        self.progress = progress
        self.imageUrl = imageUrl
        self.totalChallengeCount = totalChallengeCount
        self.daysCount = daysCount
        self.bubbleVisible = bubbleVisible
        self.completeMission = completeMission
    }
     */
    
    /*
    // 서버 모델 매핑용 이니셜라이저
    init(from response: GetChallengeStatusResponse) {
        let body = response.body
        self.nickName = body.nickName
        self.growthMessage = body.growthMessage
        self.userTitle = body.userTitle
        self.userTitleColor = body.userTitleColor
        self.progress = body.progress
        self.imageUrl = body.imageUrl
        self.totalChallengeCount = body.totalChallengeCount
        self.daysCount = body.daysCount
        self.bubbleVisible = body.bubbleVisible
        self.completeMission = body.completeMission
    }
     */
}

struct TitleComponent {
        
        let titles: [Title]
        struct Title {
            let titleId: String
            let title: String
            let titleColor: String
        }
}

extension ChallengeStatusComponent {
    init(from data: GetChallengeStatusResponse){
        self.nickName = data.nickName
        self.growthMessage = data.growthMessage
        self.userTitle = data.userTitle
        self.userTitleColor = data.userTitleColor
        self.progress = data.progress
        self.imageUrl = APIManager.shared.baseURL + data.imageUrl
        self.totalChallengeCount = data.totalChallengeCount
        self.daysCount = data.daysCount
        self.isBubbleVisible = data.isBubbleVisible
        self.isCompleteMission = data.isCompleteMission
    }
}

extension TitleComponent {
    init(from data: GetUserTitlesResponse){
        self.titles = data.titles.map {
            Title(titleId: $0.titleId, title: $0.title, titleColor: $0.titleColor)
        }
    }
}

// MARK: - Mock Data
extension ChallengeStatusComponent {
    static let mock = ChallengeStatusComponent(
        nickName: "홍길동",
        growthMessage: "열심히 성장 중이에요!",
        isBubbleVisible: true,
        userTitle: "열정러",
        userTitleColor: "#FF6B6B",
        progress: 0.5,
        imageUrl: "https://picsum.photos/200", // 임시 이미지 URL
        totalChallengeCount: 25,
        daysCount: 7,
        isCompleteMission: false
    )
}

extension TitleComponent {
    static let mock: TitleComponent = .init(
        titles: [
            .init(titleId: "1", title: "열정러", titleColor: "#FF6B6B"),
            .init(titleId: "2", title: "열정러2", titleColor: "#FF6B6B"),
        ]
    )
}
