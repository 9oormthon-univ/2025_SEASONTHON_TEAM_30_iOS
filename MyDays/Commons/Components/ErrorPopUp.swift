//
//  ErrorPopUp.swift
//  MyDays
//
//  Created by 양재현 on 9/5/25.
//

//MARK: - 에러 팝업
import SwiftUI

struct ErrorPopUpView: View {
    let title: String
    let message: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.t2())
                .foregroundColor(.white)
            
            Text(message.forceCharWrapping)
                .font(.b1())
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, 8)
            
            Button(action: { dismiss()}) {
                Text("확인")
                    .font(.b2Bold())
                    .foregroundColor(.mdBrightBlack)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16.5)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.mdPrimary)
                    )
                   
            }
            .padding(.top, 23)
        }
        .padding(.top, 32)
        .padding(.bottom, 16)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.mdSurf3)
        )
        .padding(.horizontal, 30)
        .presentationBackground(Color.black.opacity(0.5)) /*배경 투명하게*/
           
    }
}

#Preview {
    ZStack {
        Color.mdDim.ignoresSafeArea()
        ErrorPopUpView(title: "연결오류", message: "문제가 발생했습니다. 다시 시도해 주세요.")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.white)
}
