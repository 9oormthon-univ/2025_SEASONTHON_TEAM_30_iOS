//
//  CalendarView.swift
//  MyDays
//
//  Created by 양재현 on 8/31/25.
//

//MARK: - 캘린더 뷰
import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var nav: NavigationManager
    @StateObject var vm = CalendarViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                //주 단위 달력
                WeekCalendarView(selectedDate: $vm.selectedDate)
                
                
                //미션 카드
                if let dayContent = vm.selectedDayContent {
                    CalendarMissionCard(day: "DAY \(dayContent.day)", date: dayContent.date, mission: dayContent.text)
                        .padding(.top, 10)
                    
                    //선택된 날짜의 게시물
                    if let post = dayContent.post {
                        HomePostView(post: post) {
                            //좋아요 로직 처리
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 30)
                        .onTapGesture {
                            nav.push(AppRoute.postDetail)
                        }
                    }
                }
            }
            .padding(.bottom, 50) //마지막 게시물 밑에서 얼마나
        }
        .background(.mdSurf2)
        .padding(.top, -8) // ScrollView, safeAreaInset간에 조그만 gap 크기만큼 조정
        //헤더 질문
        .safeAreaInset(edge: .top) {
            CalendarHeaderView(onCalendarTap: {})
        }
        .onChange(of: vm.selectedDate) { _, _ in
            vm.selectDate()
        }
        //캘린더 뷰 조회 시
        .onAppear {
            vm.getCalendarWeek()
        }
    }
}
// MARK: - 날짜 모델
struct CalendarDay: Identifiable {
    let id = UUID()
    let date: Date
    let dayNumber: Int    // 1, 2, 3...
    let weekday: String   // 월, 화, 수...
}
// MARK: - Week Calendar View
struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    @State private var weekDays: [CalendarDay] = []
    @Namespace private var animation
    
    let calendar =  Calendar.current
    
    private func generateWeekDays() -> [CalendarDay] {
        let today = Date()
        let weekdaySymbols = ["일","월","화","수","목","금","토"]
        var days: [CalendarDay] = []
        let weekday = calendar.component(.weekday, from: today)
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i - (weekday - 1), to: today) {
                let dayNumber = calendar.component(.day, from: day)
                let weekdayString = weekdaySymbols[calendar.component(.weekday, from: day) - 1]
                days.append(CalendarDay(date: day, dayNumber: dayNumber, weekday: weekdayString))
            }
        }
        return days
    }
    
    var body: some View {
        //렌더링 막기 위해 ?
        let selectedGradient = LinearGradient(
            colors: [.mdSurf3, Color(hex: "6E6E6E")],
            startPoint: .top,
            endPoint: .bottom
        )
        
        HStack(spacing: 0) {
            ForEach(weekDays) { day in
                let isSelected = calendar.isDate(selectedDate, inSameDayAs: day.date)
                VStack(spacing: 8) {
                    //일 ~ 토
                    Text(day.weekday)
                        .font(.l1())
                        .foregroundColor(isSelected ? .mdBrightSurf : .mdDim2)
                    
                    //1 ~ 31
                    Text("\(day.dayNumber)")
                        .font(.l1())
                        .foregroundColor(.mdBrightSurf)
                }
                .frame(width: 46, height: 66)
                
                .background(
                    Group {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 100)
                                .fill(
                                    selectedGradient
                                )
                                .stroke(Color(hex: "A9A9A9"), lineWidth: 1)
                                .frame(width: 44, height: 65)
                                .matchedGeometryEffect(id: "selectedDate", in: animation)
                        }
                    }
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    //TODO: - 애니메이션 밑에 뷰들이 렌더링되서 버퍼링 ?
//                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0.7)) {
                    withAnimation {
                        selectedDate = day.date
                    }
                }
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(.mdSurf2)
        .onAppear{
            print("날짜받아옴")
            weekDays = generateWeekDays()
        }
    }
}

//MARK: - 캘린더 뷰 헤더 부분
struct CalendarHeaderView: View {
    let onCalendarTap: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            //알람
            Image("calendar.fill")
                .padding(2)
                .onTapGesture {
                    onCalendarTap()
                }
        }
        .overlay(
            Text("나의 달력")
                .font(.b1())
                .foregroundColor(.white)
        )
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
        .frame(height: 66)
        .padding(.horizontal, 30)
        .background(.mdSurf2)
    }
}

//MARK: - 캘린더 미션 카드
struct CalendarMissionCard: View {
    let day: String
    let date: String
    let mission: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            //DAY 1
            Text(day)
                .font(.b3Bold())
                .foregroundColor(.mdPrimaryText)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.mdPrimaryCon)
                )
            //9월 2일 화요일
            Text(date)
                .font(.t2())
                .foregroundColor(.white)
            
            //미션 내용
            Text(mission.forceCharWrapping)
                .font(.b2())
                .foregroundColor(.mdBrightSurf)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(30)
        .background(.mdSurf3)
    }
}


#Preview {
    NavigationStack{
        CalendarView()
    }
}
