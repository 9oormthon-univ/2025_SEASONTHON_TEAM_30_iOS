//
//  SetNicknameView.swift
//  MyDays
//
//  Created by 양재현 on 9/3/25.
//

//MARK: - 닉네임 만들기 뷰
import SwiftUI

struct SetNicknameView: View {
    @StateObject var vm = SetNicknameViewModel()
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("마이데이즈에서 사용할\n닉네임을 적어주세요")
                .font(.t2())
                .foregroundColor(.white)
                .padding(.top, 83)
            
 
            ZStack(alignment: .leading) {
                //placeholder
                if vm.nickName.isEmpty {
                    Text("닉네임을 입력해주세요")
                        .font(.b2())
                        .foregroundColor(.mdDim)
                        .padding(.leading, 10)
                }
                
                //텍스트 필드
                TextField("", text: $vm.nickName)
                    .accentColor(.white)
                    .font(.b2())
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .padding(.vertical, 16.5)
                    .overlay(alignment: .bottom) {
                        Divider()
                            .frame(height: 1)
                            .overlay(.white)
                    }
                    .onChange(of: vm.nickName) { _, newValue in
                        // 입력할 때마다 유효성 검사
                        if !newValue.isEmpty {
                            vm.isNicknameValid = vm.isNicknameValid(newValue)
                        }
                    }
                
                
            }
            .padding(.top, 104)
            
            //닉네임 형식 올바르지 않을때 문구
            if !vm.isNicknameValid {
                Text("닉네임은 1~12자, 한글, 영어, 숫자만 가능합니다.")
                    .foregroundColor(Color(hex: "FF5454"))
                    .font(.b3())
                    .padding(.top, 12)
                    .padding(.leading, 19)
            }
            
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            Image("logo.set.nickname")
        }
        
        .padding(.horizontal, 30)
        .background(.mdSurf2)
        //다음 플로팅 버튼
        .safeAreaInset(edge: .bottom) {
            Button("다음") { vm.setNickname() }
                .buttonStyle(.primary(isDisabled: vm.isDisabled))
                .padding(.horizontal, 30)
                .padding(.bottom, 10)
                .disabled(vm.isDisabled)
        }
        //닉네임 설정 성공 시 감지해서 메인 화면으로 전환
        .onChange(of: vm.isSwitchMain) { _, newValue in
            if newValue {
                nav.popToRoot()
                appState.currentView = .main
                vm.isSwitchMain = false // 플래그 리셋 (중복 이동 방지)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SetNicknameView()
    }
}
