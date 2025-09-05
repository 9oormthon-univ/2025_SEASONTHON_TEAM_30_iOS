//
//  CompletedLoginView.swift
//  MyDays
//
//  Created by 양재현 on 9/5/25.
//

//MARK: - 닉네임 설정 완료한 뷰
import SwiftUI

struct CompletedLoginView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var nav: NavigationManager
    let nickName: String
    
    var body: some View {
        VStack(spacing: 0) {
            Text("로그인 완료!")
                .font(.t2())
                .foregroundColor(.white)
            
            Text("\(nickName) 님,\n환영해요!")
                .font(.t1())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Image("char.completed.login")
                .resizable()
                .frame(width: 162, height: 162)
            
            Button("홈으로 이동하기") {
                nav.popToRoot()
                appState.currentView = .main
            }
            .buttonStyle(.primary(isDisabled: false))
            .padding(.top, 30)
          
        }
        .toolbar(.hidden, for: .navigationBar)
        .padding(.horizontal, 30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.mdNavi1)
    }
}


#Preview {
    CompletedLoginView(nickName: "가나다라마바사")
}
