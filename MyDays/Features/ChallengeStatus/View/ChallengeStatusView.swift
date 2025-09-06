//
//  ChallengeStatusView.swift
//  MyDays
//
//  Created by Apple on 8/31/25.
//

// MARK: - 챌린지 현황(View) 입니다.

import Kingfisher
import SwiftUI

struct ChallengeStatusView: View {
    @StateObject var vm = ChallengeStatusViewModel()
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.mdSurf2.ignoresSafeArea()
            
            if let challengeStatus = vm.component {
                // 콘텐츠들 중앙 배치
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing:10) {
                        // 사용자 이름 + "님"
                        Text("\(challengeStatus.nickName) 님") // ViewModel의 데이터를 사용
                            .font(.t1())
                            .foregroundColor(.white)
                        
                        // ViewModel의 상태에 따라 메시지 표시
                        Text(challengeStatus.growthMessage)
                            .font(.b2())
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading) // 내부 VStack은 꽉 채우고 왼쪽 정렬
                    .padding(.bottom, 8)
                    
                    //TODO: 가이드라인 STEP 5 참고해서 변경
                    // ProfileCard(vm: vm)
                    ProfileCard(challengeStatus: challengeStatus, onTitleTap: { vm.handleTitleAreaTap() })
                    
                    // 오늘의 챌린지 작성하기 버튼
                    Button(action: { nav.push(AppRoute.write)})
                    {
                        Text(challengeStatus.isCompleteMission ? "오늘의 챌린지를 완료했어요" : "오늘의 챌린지 작성하기")
                    }
                    .buttonStyle(TodaysChallengeWriteButtonStyle())
                    .disabled(challengeStatus.isCompleteMission)
                    .padding(.top,8)
                    
                }
                .padding(.top, 59)
                .frame(maxWidth: 318) // 전체 column의 기준 폭을 카드와 동일하게 설정
                .frame(maxWidth: .infinity)
                
            }
            ChallengeStatusHeaderView(onSettingsTap: {
                nav.push(AppRoute.settings)
            })
            
            // 뷰가 나타날 때 데이터를 불러오는 코드 추가하는 부분
            .onAppear {
                // 뷰가 나타날 때마다 챌린지 상태를 다시 불러옴
                Task {
                    await vm.fetchChallengeStatus()
                }
                
            }
        }
        
        // sheet 수정자를 이용해 별명 선택 창을 띄우기
        .sheet(isPresented: $vm.isShowingTitleSelection) {
            // TitleSelectionView에 전달
            TitleSelectionView(vm: vm)
                .presentationDetents([.height(417)]) // sheet의 높이 지정
                .presentationCornerRadius(30)
                //.presentationBackground(.clear)
        }
    }
    
    
    
    // MARK: - 헤더
    struct ChallengeStatusHeaderView: View {
        // 버튼 탭 시 실행될 클로저
        let onSettingsTap: () -> Void
        
        var body: some View {
            HStack (spacing: 0){
                Spacer()
                // 설정
                Image("settings")
                    .padding(10)
                    .onTapGesture {
                        // 설정 화면으로 넘어가기
                        onSettingsTap()
                    }
            }
            .overlay(
                Text("챌린지 현황")
                    .font(.b1())
                    .foregroundColor(.white)
            )
            .frame(height: 56)
            .padding(.horizontal, 28.5)
            .padding(.bottom,3)
            .background(.mdSurf2)
        }
    }
    
    //MARK: - 칭호 + 진행률바 + 슬라임 이미지 + 달력 + 스트리크
    struct ProfileCard: View {
        // @ObservedObject var vm: ChallengeStatusViewModel
        let challengeStatus: ChallengeStatusComponent
        let onTitleTap: () -> Void
        
        var body: some View {
            
            VStack(spacing: 29) {
                // 칭호
                UserTitleBadge(title: challengeStatus.userTitle, color: challengeStatus.userTitleColor)
                    .onTapGesture {
                        // vm.handleTitleAreaTap()
                        onTitleTap()
                    }
                
                // 진행률바
                // TODO: !!
                ZStack {
                    // 새로 만든 ProgressRingView를 배경에 배치
                    ProgressRingView(progress: challengeStatus.progress)
                        .frame(width: 100, height: 92.5)
                    
                    // 슬라임 이미지를 ProgressRingView 위에 올림
                    KFImage(URL(string: challengeStatus.imageUrl))
                        .placeholder { // 로딩 중 보여줄 뷰
                            Circle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 162, height: 162)
                         }
                         .cancelOnDisappear(true)
                         .resizable()
                         .scaledToFill()
                         .frame(width: 162, height: 162)
                         .clipped()
                         .clipShape(Circle())
                }
                
                // "성장까지"와 "연속" 정보를 담을 HStack
                HStack(spacing: 79){
                    // "성장까지" 그룹
                    VStack(spacing: 0) {
                        Image("stack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 20.5)
                            .padding(.bottom, 8)
                        Text("누적 챌린지\n\(challengeStatus.totalChallengeCount) 개")
                            .font(.b3())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        // TODO: ViewModel에서 실제 데이터를 받아와야 합니다.
                    }
                    
                    // "연속" 그룹
                    VStack(spacing: 0) {
                        Image("streak")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 17, height: 23)
                            .padding(.horizontal, 4)
                            .padding(.bottom, 8)
                        Text("연속\n\(challengeStatus.daysCount) 일")
                            .font(.b3Light())
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        // TODO: ViewModel에서 실제 데이터를 받아와야 합니다.

                    }
                }
                
            }
            .frame(maxWidth: 318)
            .frame(maxHeight: 392)
            .background(.mdSurf3)
            .cornerRadius(12)
            .overlay(alignment: .top) {
                if challengeStatus.isBubbleVisible {
                    Text("별명을 변경해보세요!")
                        .font(.l1())
                        .foregroundColor(.white)
                        .padding(.horizontal,12)
                        .padding(.vertical, 8)
                        .background(
                            SpeechBubble()
                                .fill(.mdSurf4)
                        )
                        .offset(y: -12)
                }
            }
        }
    }
    
    //MARK: - 말풍선 모양 정의
    struct SpeechBubble: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            
            // 둥근 사각형 그리기
            path.addRoundedRect(in: rect, cornerSize: CGSize(width: 12, height: 12))
            
            // 꼬리(삼각형) 그리기
            path.move(to: CGPoint(x: rect.midX - 10, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY + 10))
            path.addLine(to: CGPoint(x: rect.midX + 10, y: rect.maxY))
            
            return path
        }
    }
    
    
    
    // MARK: - 오늘의 챌린지 작성하기 버튼
    struct TodaysChallengeWriteButtonStyle: ButtonStyle {
        @Environment(\.isEnabled) private var isEnabled
        
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(isEnabled ? .b2Bold() : .b2())
                .foregroundColor(isEnabled ? .mdBrightSurf : .mdDim)
                .frame(maxWidth: 315)
                .frame(height: 56)
                .background(isEnabled ? .mdSurf4 : .mdNavi2)
                .cornerRadius(12)
                .overlay {
                    if isEnabled {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.mdDim, lineWidth: 1) // 색상: .mdDim, 굵기: 1
                                }
                            }
        }
    }
}

// MARK: - 진행률 바
// TODO: !!
struct ProgressRingView: View {
    // 0.0 ~ 1.0 사이의 진행률 값
//    let challengeStatus: ChallengeStatusComponent
    let progress: Double
    
    var body: some View {
        ZStack {
            // 배경 트랙 (항상 보이는 회색 라인)
            Circle()
                .trim(from: 0, to: 0.5) // 1/2 원 모양으로 자르기
                .stroke(style: StrokeStyle(lineWidth: 5.32, lineCap: .round))
                .foregroundColor(.mdSurf3) // 배경 트랙 색상
                .rotationEffect(.degrees(180)) // 시작점을 왼쪽 아래로 회전
            
            // 진행률 바 (챌린지 횟수에 따라 채워짐)
            Circle()
                .trim(from: 0, to: 0.5 * progress) // 전체의 1/2 중에서 progress 만큼만 그림
                .stroke(style: StrokeStyle(lineWidth: 5.32, lineCap: .round))
                .fill(
                    // 그라데이션 적용
                    AngularGradient(
                        gradient: Gradient(colors: [.white, .white.opacity(0.3)]),
                        center: .center,
                        startAngle: .degrees(180),
                        endAngle: .degrees(180 + (360 * 0.5))
                    )
                )
                .rotationEffect(.degrees(180))
        }
    }
}

#Preview {
    ProgressRingView(progress: 0.4)
}
