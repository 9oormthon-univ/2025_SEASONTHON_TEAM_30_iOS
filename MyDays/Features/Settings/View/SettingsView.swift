//
//  SettingsView.swift
//  MyDays
//
//  Created by Apple on 9/1/25.
//
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var nav: NavigationManager
    @StateObject var vm = SettingsViewModel()
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.mdNavi1.ignoresSafeArea() //로딩중에도 백그라운드 주기위해서
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    //MARK: - 알림 설정
                    HStack{
                        Text("알림 설정")
                            .font(.b1())
                            .foregroundColor(.white)
                        
                        Spacer() // 토글을 오른쪽 끝으로 밀어내기
                        
                        Toggle("", isOn: $vm.isToggleOn)
                            .tint(.mdPrimary)
                            //토글이 off면 알람 끄기
                            .onChange(of: vm.isToggleOn) { _, newValue in
                                    if newValue == false {
                                        Task {
                                            await vm.cancelNotifications()
                                        }
                                    }
                            }
                    }
                    .padding(.horizontal, 20)
                    
                    
                    // MARK: - 시간변경
                    HStack(spacing: 0) {
                        Text("매일 챌린지를 리마인드 해드릴게요!")
                            .font(.b3())
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: { vm.isShowTimeChangePopUp.toggle() }) {
                            Text("시간변경")
                                .font(.b3())
                                .foregroundColor(vm.isToggleOn ? .white : .mdDim)
                                .underline()
                        }
                        .disabled(!vm.isToggleOn)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.mdSurf3)
                    )
                    .padding(.top, 10)
                    
                    
                    // 구분선 : 색상, 길이 모두 수정 완료
                    Divider()
                        .background(Color(hex:"#969696"))
                        .padding(.top, 10)
                    
                    
                    //MARK: - 로그아웃
                    Button(action: {
                        vm.isShowLogoutAlert.toggle()
                    }){
                        HStack{
                            Text("로그아웃")
                                .font(.b1())
                                .foregroundColor(.white)
                            
                            Spacer()
                            Image("circle.right")
                                .foregroundColor(.white)
                            
                        }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    
                    Divider()
                        .background(Color(hex:"#969696"))
                        .padding(.top, 10)
                    
                    
                    // MARK: - 회원 탈퇴
                    Button(action: {
                        vm.isShowDeleteAlert.toggle()
                    }){
                        HStack{
                            Text("회원 탈퇴")
                                .font(.b1())
                                .foregroundColor(.mdDim)
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.top, 10)
                }
                
            }
            //ㅎㅔㄷㅓ
            .safeAreaInset(edge: .top, spacing: 0){
                SettingsHeaderView(onBackTap: {
                    nav.popLast()
                })
            }
            .padding(.horizontal, 30)
        }
        //로그아웃, 회원탈퇴 로딩로티
        .overlay(
            Group {
                   if vm.isLoading {
                       LoadingLottieView(animationFileName: "Loading", loopMode: .loop)
                   }
               }
        )
        .toolbar(.hidden, for: .navigationBar)
        //로그아웃 알럿
        .alert("정말로 로그아웃 하시겠습니까?", isPresented: $vm.isShowLogoutAlert) {
            Button("확인", role: .none) {
                vm.logout()
            }
            Button("취소", role: .cancel) {}
        }
        //회원탈퇴 알럿
        .alert("정말로 회원탈퇴 하시겠습니까?", isPresented: $vm.isShowDeleteAlert) {
            Button("확인", role: .none) {
                vm.deleteAccount()
            }
            Button("취소", role: .cancel) {}
        }
        //달력 아이콘 누르면 월 단위 캘린더 뷰 등장
        .fullScreenCover(isPresented: $vm.isShowTimeChangePopUp) {
            TimeChangePopUp(selectedDate: $vm.selectedDate) {
                Task { await vm.scheduleNotification() }
            }
        }
        //로그아웃, 회원탈퇴 감지해서 로그아웃 페이지로 이동
        .onChange(of: vm.goToLoginView) { _, newValue in
            if newValue {
                nav.popToRoot() //패스 다 없애고
                appState.currentView = .login //로그인 뷰로 이동
                vm.goToLoginView = false // 플래그 리셋 (중복 이동 방지)
            }
        }
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
        //        .padding(.horizontal, 30) // 좌우 여백
        .padding(.bottom,10)
        .background(.mdNavi1) // 배경색 지정
    }
}

//MARK: - 시간변경 팝업
struct TimeChangePopUp: View {
    @Binding var selectedDate: Date
    @Environment(\.dismiss) var dismiss
    let onConfirm: () -> Void
    
    var body: some View {
        VStack (spacing: 0) {
            Text("시간 설정")
                .font(.t2())
                .foregroundColor(.white)
            
            //설정된 시간으로 알림 보내기
            DatePicker("알림 시간", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
    
            
            Button("확인") {
                onConfirm()
                dismiss()
            }
            .buttonStyle(.primary(isDisabled: false))
            
        }
        .padding(.horizontal, 16)
        .padding(.top, 32)
        .padding(.bottom, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.mdSurf3)
        )
        .padding(.horizontal, 30)
        .presentationBackground(Color.black.opacity(0.5)) /*배경 투명하게*/
    }
}


#Preview {
    // Preview에서 실제로 어떻게 보일지 확인하기 위해 NavigationStack으로 감싸줍니다.
    NavigationStack {
        SettingsView()
            .environmentObject(NavigationManager())
    }
}
