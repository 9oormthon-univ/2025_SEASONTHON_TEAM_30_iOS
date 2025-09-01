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
    
    // MARK: - 날짜 같은지 비교
    func isSameDay(_ lhs: Date, _ rhs: Date) -> Bool {
        return calendar.isDate(lhs, inSameDayAs: rhs)
    }
    
    // MARK: - 이번 주 7일 생성
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
    
    // MARK: - 시작~끝 월까지 MonthCalendarDay 배열 생성
    func generateMonths(from startDate: Date, to endDate: Date) -> [[CalendarDay]] {
        var months: [[CalendarDay]] = []
        var currentDate = startDate.startOfMonth()
        
        while currentDate <= endDate {
            months.append(generateMonthDays(from: currentDate))
            currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
        }
        
        return months
    }
    
    // MARK: - 한 달 날짜 생성 (1일~말일)
    private func generateMonthDays(from referenceDate: Date = Date()) -> [CalendarDay] {
        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: referenceDate)), //월의 시작일 구하기
              let range = calendar.range(of: .day, in: .month, for: referenceDate) else { return [] } //한 달의 날짜 범위 구하기
        
        var days: [CalendarDay] = []
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        
        // 월 초 빈 칸 (ex. 9월 1일이 수요일이면 월, 화에 빈 칸을 넣음 day == 0이면 )
        for _ in 1..<firstWeekday {
            days.append(CalendarDay(date: Date.distantPast, dayNumber: 0, weekday: ""))
        }
        
        // 실제 날짜
        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                let weekdayString = weekdaySymbols[calendar.component(.weekday, from: date) - 1]
                days.append(CalendarDay(date: date, dayNumber: day, weekday: weekdayString))
            }
        }
        return days
    }
}



