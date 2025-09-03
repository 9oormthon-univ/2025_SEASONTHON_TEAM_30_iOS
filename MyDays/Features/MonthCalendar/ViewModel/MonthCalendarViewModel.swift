//
//  MonthCalendarViewModel.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

//MARK: - 월 단위 달력 뷰모델 입니다.
import Foundation

@MainActor
class MonthCalendarViewModel: ObservableObject {
    @Published var months: [[CalendarDay]] = [] //1월(1~31일), 2월(1~31일) 달력묶음
    @Published var posts: [MonthCalendarPost] = [] //(postPk, 이미지url, date)의 리스트
    @Published var showCompletedDetail: Bool = false //완료한 디테일 페이지로 이동시켜야하는지
    @Published var selectedPostId: String = "" //날짜 터치된 게시물 id
    
    private let calendarManager = CalendarManager()
    private let mnthCalendarService = MockMonthCalendarService() //의존성 주입 (Real or Mock)

    //MARK: - 월 단위 달력 뷰 조회
    func getMonthCalendar() {
        Task {
            //유저 생성일, 게시물 리스트로 받아옵니다.
            do {
                let (fetchedUserCreatedAt, fetchedPosts) = try await mnthCalendarService.getCalendarPosts()
                
                // startDate부터 오늘까지 모든 달 생성
                self.months = calendarManager.generateMonths(from: fetchedUserCreatedAt, to: Date())
                self.posts = fetchedPosts
            }
            catch{
                print("‼️월 단위 달력 조회 에러\(error)")
            }
            
           
        }
    }
    
}
