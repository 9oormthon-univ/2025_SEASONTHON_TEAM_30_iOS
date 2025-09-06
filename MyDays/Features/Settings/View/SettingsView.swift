//
//  SettingsView.swift
//  MyDays
//
//  Created by Apple on 9/1/25.
//
import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var nav: NavigationManager
    
    // 토그 상태 저장 및 변경하기 위한 변수
    @State private var isNotificationEnabled: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            
            // 알림 설정
            HStack{
                Text("알림 설정")
                    .font(.b1())
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                Spacer() // 토글을 오른쪽 끝으로 밀어내기
                
                Toggle("", isOn: $isNotificationEnabled)
                    .tint(.mdPrimary)
                    .padding(.horizontal,20)
            }
            .padding(20)
            
            // 구분선 : 색상, 길이 모두 수정 완료
            Divider()
                .background(Color(hex:"#969696"))
                .padding(.horizontal,30)
            
            // 로그아웃
            Button(action: {
                // TODO: ViewModel 로그아웃 기능 호출
                print("로그아웃")
            }){
                HStack{
                    Text("로그아웃")
                        .font(.b1())
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                    Spacer()
                    Image("circle.right")
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                }
            }
            .padding(20)
            
            Divider()
                .background(Color(hex:"#969696"))
                .padding(.horizontal,30)
            
            // 회원 탈퇴
            Button(action: {
                // TODO: ViewModel 회원 탈퇴 기능 호출
                print("회원 탈퇴")
            }){
                HStack{
                    Text("회원 탈퇴")
                        .font(.b1())
                        .foregroundColor(.mdDim)
                        .padding(.horizontal,20)
                    Spacer()
                }
            }
            .padding(20)
            
            Spacer() // 모든 콘텐츠 위로 밀어올리기
        }
        .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                // 배경색 안전 영역까지 확장
                .background(Color.mdNavi1.ignoresSafeArea())
                .safeAreaInset(edge: .top, spacing: 0){
                    SettingsHeaderView(onBackTap: {
                        nav.popLast()
                    })
                }
                .toolbar(.hidden, for: .navigationBar)
                // 상태 표시줄 텍스트 흰색
                .preferredColorScheme(.dark)
    }
}
#Preview {
    // Preview에서 실제로 어떻게 보일지 확인하기 위해 NavigationStack으로 감싸줍니다.
    NavigationStack {
        SettingsView()
            .environmentObject(NavigationManager())
    }
}

// MARK: - 헤더
struct SettingsHeaderView: View {
    // 뒤로가기 버튼을 눌렀을 때 실행될 액션
    let onBackTap: () -> Void
    
    var body: some View {
        HStack {
            // 뒤로가기 버튼
            Button(action: onBackTap) {
                Image("arrow.left") // 원하는 이미지
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
            }
            
            Spacer() // 빈 공간을 채워 제목을 중앙으로 밀어냅니다.
        }
        .overlay(
            // 중앙 정렬된 제목
            Text("설정")
                .font(.b1())
                .foregroundColor(.white)
        )
        .frame(height: 72) // 헤더 높이
        .padding(.horizontal, 30) // 좌우 여백
        .padding(.bottom,10)
        .background(.mdNavi1) // 배경색 지정
    }
}
