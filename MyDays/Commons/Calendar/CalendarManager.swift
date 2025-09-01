//
//  CalendarManager.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

//MARK: - 캘린더 매니저
import Foundation

struct CalendarManager {
    private let calendar = Calendar.current
    private let weekdaySymbols = ["일","월","화","수","목","금","토"]
    
    // 이번 주 7일 생성
    func generateWeekDays(from referenceDate: Date = Date()) -> [CalendarDay] {
        var days: [CalendarDay] = []
        let weekday = calendar.component(.weekday, from: referenceDate)
        
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i - (weekday - 1), to: referenceDate) {
                let dayNumber = calendar.component(.day, from: day)
                let weekdayString = weekdaySymbols[calendar.component(.weekday, from: day) - 1]
                days.append(CalendarDay(date: day, dayNumber: dayNumber, weekday: weekdayString))
            }
        }
        return days
    }
    
    // 날짜가 같은지 비교
    func isSameDay(_ lhs: Date, _ rhs: Date) -> Bool {
        return calendar.isDate(lhs, inSameDayAs: rhs)
    }
    
//    // 요일 문자열 가져오기
//    func weekdayString(for date: Date) -> String {
//        let weekday = calendar.component(.weekday, from: date)
//        return weekdaySymbols[weekday - 1]
//    }
}
