//
//  CompletedMission.swift
//  MyDays
//
//  Created by 양재현 on 9/4/25.
//

//MARK: - 완료한 미션 카드 모델
import Foundation

struct CompletedMission {
    let date: String //날짜 (ex. 9월 2일 화요일)
    let text: String //완료한 미션 내용 (ex. 나의 장점 3가지는 무엇입니까 ?)
}

//서버 모델 매핑용 이니셜라이저
extension CompletedMission {
    init(from data: CompletedDetailResponse.MissionResponse) {
        self.date = data.date
        self.text = data.missionText
    }
}

// MARK: - Mock Data
extension CompletedMission {
    static let mock: CompletedMission = CompletedMission(
        date: "9월 2일 화요일",
        text: "당신을 행복하게 하는 음악을 찾아 듣고 공유해보세요."
    )
}
