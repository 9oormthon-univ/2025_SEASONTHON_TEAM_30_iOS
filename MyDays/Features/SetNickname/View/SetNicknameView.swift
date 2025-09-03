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
        VStack(spacing: 0) {
            Text("마이데이즈에서 사용할\n닉네임을 적어주세요")
                .foregroundColor(.white)
            
            TextField("닉네임을 입력해주세요", text: $vm.nickName)
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1) // 테두리
                )
            //TODO: 정규식
            
            Spacer()
            Button(action: { vm.setNickname() }) { //TODO: isLoading이면 프로그레스바?
                Text("닉네임 설정 완료")
                    .foregroundColor(.white)
            }
            .disabled(vm.isDisabled)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mdSurf2)
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
