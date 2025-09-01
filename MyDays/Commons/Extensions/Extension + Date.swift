//
//  Extension + Date.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

// MARK: - Extension + Date (주 단위, 월 단위 캘린더용)

import Foundation

// 현재 날짜의 연도, 월, 일 값을 Int로 반환
extension Date {
    var year: Int { Calendar.current.component(.year, from: self) }
    var month: Int { Calendar.current.component(.month, from: self) }
    var day: Int { Calendar.current.component(.day, from: self) }
}

//현재 날짜가 속한 달의 첫째 날을 쉽게 가져오는 유틸리티 함수
extension Date {
    func startOfMonth() -> Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }
}

