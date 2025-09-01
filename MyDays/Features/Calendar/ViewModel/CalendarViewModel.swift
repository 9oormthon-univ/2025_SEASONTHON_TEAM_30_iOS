//
//  CalendarViewModel.swift
//  MyDays
//
//  Created by 양재현 on 8/31/25.
//

//MARK: - 캘린더 뷰모델 입니다.
import Foundation

@MainActor
class CalendarViewModel: ObservableObject {
    @Published var dayContents: [DayContent] = [] //미션들 + 게시물들
    @Published var selectedDate: Date = Date() //선택된 날짜
    @Published var weekDays: [CalendarDay] = [] //이번 주 날짜들
    
    @Published var selectedDayContent: DayContent? //선택된 날짜의 콘텐츠 (미션 + 게시물)
    
    private let calendarService = MockCalendarService() //의존성 주입 (Real or Mock)

    //MARK: - 캘린더 뷰 조회
    func getCalendarWeek() {
        Task {
            let fetchedDayContents = try await calendarService.getCalendarWeeks()
            
            self.dayContents = fetchedDayContents
            selectDate() //처음에도 선택되게 하기 위해
        }
    }
    
    //MARK: - 그날 날짜 선택되면 필터링
    func selectDate() {
        let day = Calendar.current.component(.day, from: selectedDate)
        self.selectedDayContent = dayContents.first { $0.day == day }
    }
}
