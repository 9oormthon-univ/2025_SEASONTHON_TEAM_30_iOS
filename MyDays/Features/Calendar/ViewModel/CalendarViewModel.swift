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
    @Published var showMonthCalendar: Bool = false //월 단위 캘린더 뷰 풀 스크린 여부
    
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
    
    //MARK: - 좋아요 누르기/취소
    func postLike(post: Post) {
        Task {
            do {
                _ = try await calendarService.postlike(postId: post.id)
                
                // 좋아요 상태 토글 (로컬에서)
                if let index = dayContents.firstIndex(where: { $0.post?.id == post.id }),
                   var updatedPost = dayContents[index].post {
                    
                    // 좋아요 상태 토글
                    updatedPost.isLiked.toggle()
                    updatedPost.likeCount += updatedPost.isLiked ? 1 : -1
                    
                    // 업데이트된 post를 다시 넣어주기
                    dayContents[index].post = updatedPost
                    
                    // 선택된 날짜 업데이트
                    if selectedDayContent?.day == dayContents[index].day {
                        selectedDayContent = dayContents[index]
                    }
                }
            }
            catch {
                print("‼️좋아요 오류")
            }
        }
    }
}
