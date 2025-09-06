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
    var isBubbleVisible: Bool
    let userTitle: String
    let userTitleColor: String
    let progress: Double
    let imageUrl: String
    let totalChallengeCount: Int
    let daysCount: Int
    let isCompleteMission: Bool
    
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
        progress: 0.9,
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
