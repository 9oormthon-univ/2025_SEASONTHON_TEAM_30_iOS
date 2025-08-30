//
//  WriteMission.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 글쓰기 화면에서 미션 모델
import Foundation

struct WriteMission {
    let day: String //오늘 Day (ex. Day 1)
    let text: String //오늘의 미션 내용 (ex. 나의 장점 3가지는 무엇입니까 ?)
    let isCompleted: Bool //미션 완료했는지
}

//서버 모델 매핑용 이니셜라이저
extension WriteMission {
    init(from data: GetWritePageResponse) {
        self.day = data.day
        self.text = data.missionText
        self.isCompleted = data.isCompleted
    }
}

//MARK: - Mock Data
extension WriteMission {
    static let mock = WriteMission(
        day: "Day 1",
        text: "나의 장점 3가지는 무엇입니까???",
        isCompleted: false
    )
}
