//
//  MonthCalendarView.swift
//  MyDays
//
//  Created by 양재현 on 9/1/25.
//

//MARK: - 월 단위 달력 뷰
import SwiftUI
import Kingfisher

struct MonthCalendarView: View {
    @StateObject var vm = MonthCalendarViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Group {
            //캘린더 1개만 있으면 중앙정렬
            if vm.months.count == 1 {
                VStack {
                    MonthCalendar(monthDays: vm.months.first!, posts: vm.posts)
                }
                .frame(maxHeight: .infinity)
                .padding(.bottom, 62 + 66) //safeArea + top 합친게 62 + 66
            }
            //캘린더 2개이상이면 스크롤뷰
            else {
                ScrollView {
                    LazyVStack(spacing: 30) {
                        ForEach(vm.months.reversed(), id: \.self) { monthDays in
                            MonthCalendar(monthDays: monthDays, posts: vm.posts)
                        }
                    }
                    .padding(.top, 20)
                }
                .background(.mdSurf3)
            }
        }
        .background(.mdSurf3)
        .padding(.top, -8) //스크롤뷰랑 safeArea 조그만 갭...바로잡기
        //상단 바 (챌린지 피드 + 뒤로가기 버튼)
        .safeAreaInset(edge: .top) {
            VStack(spacing: 0) {
                Text("나의 달력")
                    .font(.b1())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 66)
                    .background(.mdSurf3)
                //X 버튼
                    .overlay(alignment: .trailing) {
                        Image("close")
                        //TODO: 디자이너한테 아이콘 이미지 물어보기
                //                            .resizable()
                //                            .frame(width: 15, height: 15)
                            .onTapGesture {
                                dismiss()
                            }
                            .padding(.horizontal, 30)
                    }
            }
        }
        .onAppear {
            vm.getMonthCalendar()
        }
        
    }
}

//MARK: - 달력
struct MonthCalendar: View {
    @EnvironmentObject var nav: NavigationManager
    let monthDays: [CalendarDay] //해당 월의 날짜 리스트
    let posts: [MonthCalendarPost]
    
    private let calendarManager = CalendarManager()
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            //2025년 9월
            if let firstDay = monthDays.first(where: { $0.dayNumber != 0 }) {
                Text("\(String(format: "%d", firstDay.date.year))년 \(firstDay.date.month)월")
                    .font(.t2())
                    .foregroundColor(.white)
                    .padding(.horizontal, 40)
            }
            
            //달력
            VStack(spacing: 10) {
                // 요일 헤더
                HStack(spacing: 0) {
                    ForEach(["일","월","화","수","목","금","토"], id: \.self) { weekday in
                        Text(weekday)
                            .font(.l1Light())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 45)
                    }
                }
                
                // 달력 그리드 (각 날짜)
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(monthDays) { day in
                        //저번 달은 0으로 처리했음요
                        if day.dayNumber == 0 {
                            Text("")
                                .frame(maxWidth: .infinity, minHeight: 45)
                        }
                        //각 날짜 (1, 2, 3 ...)
                        else {
                            //각 날짜에 해당하는 포스트가 있는지
                            let post = posts.first { post in
                                calendarManager.isSameDay(post.date, day.date)
                            }
                            
                            ZStack {
                                //게시물과 같은 날이면 이미지 표시
                                if let post = post {
                                    //TODO: - 네비게이션 푸시 말고 풀스크린 방안도 생각 ..
                                    Button(action: { nav.push(AppRoute.postDetail) }) {
                                        KFImage(URL(string: post.imageUrl))
                                            .placeholder { // 로딩 중 보여줄 뷰
                                                Circle()
                                                    .fill(Color.gray.opacity(0.3))
                                                    .frame(width: 45, height: 45)
                                            }
                                            .cancelOnDisappear(true)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 45, height: 45)
                                            .clipped()
                                            .clipShape(Circle())
                                    }
                                }
                                //각 날짜
                                Text("\(day.dayNumber)")
                                    .font(.l1())
                                    .frame(maxWidth: .infinity, minHeight: 45)
                                    .foregroundColor(post == nil ? .white : .mdPrimary)
                                    .allowsHitTesting(false) //사진 터치가 막혀서 방지를 위해
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 6)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.mdNavi2)
            )
            .padding(.horizontal, 24)
        }
    }
}


#Preview {
    NavigationStack{
        MonthCalendarView()
            .environmentObject(NavigationManager())
    }
}
