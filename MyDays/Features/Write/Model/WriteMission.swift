//
//  WriteMission.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 글쓰기 화면에서 미션 모델
import Foundation

struct WriteMission {
    let text: String //오늘의 미션 내용 (ex. 나의 장점 3가지는 무엇입니까 ?)
}

//서버 모델 매핑용 이니셜라이저
extension WriteMission {
    init(from data: GetWritePageResponse) {
        self.text = data.missionText
    }
}

//MARK: - Mock Data
extension WriteMission {
    static let mock = WriteMission(
        text: "당신을 행복하게 하는 음악을 찾아 듣고 공유해보세요."
    )
}
