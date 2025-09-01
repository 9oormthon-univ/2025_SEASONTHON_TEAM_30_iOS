//
//  CalendarDay.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

// MARK: - 날짜 모델
import Foundation

struct CalendarDay: Identifiable, Hashable {
    let id = UUID()
    let date: Date
    let dayNumber: Int    // 1, 2, 3...
    let weekday: String   // 월, 화, 수...
}
