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
        ZStack {
            Color.mdSurf2.ignoresSafeArea() //로딩중에도 백그라운드 주기위해서
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    //주 단위 달력
                    WeekCalendarView(selectedDate: $vm.selectedDate, weekDays: $vm.weekDays)
                    
                    
                    //미션 카드
                    if let dayContent = vm.selectedDayContent {
                        CalendarMissionCard(date: dayContent.date,
                                            mission: dayContent.text,
                                            isCompleted: dayContent.isCompleted)
                        .padding(.top, 20)
                        .padding(.horizontal, 30)
                        
                        //선택된 날짜의 게시물
                        if let post = dayContent.post {
                            HomePostView(post: post) {
                                vm.postLike(post: post)
                            }
                            .contentShape(Rectangle())
                            .padding(.horizontal, 24)
                            .padding(.top, 46)
                            .onTapGesture {
                                nav.push(AppRoute.postDetail(postId: post.id))
                            }
                        }
                    }
                }
                .padding(.bottom, 50) //마지막 게시물 밑에서 얼마나
            }
        }
        .background(.mdSurf2)
        .padding(.top, -8) // ScrollView, safeAreaInset간에 조그만 gap 크기만큼 조정
        //헤더 질문
        .safeAreaInset(edge: .top) {
            CalendarHeaderView(onCalendarTap: {
                vm.showMonthCalendar.toggle()
            })
        }
        .onChange(of: vm.selectedDate) { _, _ in
            withAnimation { //주 단위 달력 밑에 뷰들도 애니메이션 효과
                vm.selectDate()
            }
        }
        //달력 아이콘 누르면 월 단위 캘린더 뷰 등장
        .fullScreenCover(isPresented: $vm.showMonthCalendar) {
                MonthCalendarView()
        }
        //캘린더 뷰 조회 시
        .onAppear {
            vm.getCalendarWeek()
        }
    }
}

// MARK: - Week Calendar View
struct WeekCalendarView: View {
    @Binding var selectedDate: Date
    @Binding var weekDays: [CalendarDay]
    @Namespace private var animation
    
    private let calendarManager = CalendarManager()
    
    var body: some View {
        //중복 렌더링 막기 위해 ?
        let selectedGradient = LinearGradient(
            colors: [.mdSurf3, Color(hex: "6E6E6E")],
            startPoint: .top,
            endPoint: .bottom
        )
        
        HStack(spacing: 0) {
            ForEach(weekDays) { day in
                let isSelected = calendarManager.isSameDay(selectedDate, day.date)
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
            weekDays = calendarManager.generateWeekDays()
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
    let date: String
    let mission: String
    let isCompleted: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            //9월 2일 화요일
            Text(date)
                .font(.t2())
                .foregroundColor(.white)
            
            //미션 내용
            Text(mission.forceCharWrapping)
                .font(.b2Bold())
                .foregroundColor(.white)
            
            if isCompleted {
                //도전 완료 체크 박스
                HStack(spacing: 0) {
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Text("도전 완료")
                            .font(.l1())
                            .foregroundColor(.white)
                        
                        Image("check")
                    }
                    .padding(.leading, 16)
                    .padding(.trailing, 4)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 100)
                            .fill(Color(hex: "606060"))
                    )
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.mdSurf3)
                .stroke(.mdDim, lineWidth: 1)
        )
    }
}


#Preview {
    NavigationStack{
        CalendarView()
    }
}
