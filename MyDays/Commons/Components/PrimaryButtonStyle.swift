//
//  PrimaryButtonStyle.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - Primary 버튼 스타일
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    let isDisabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(isDisabled ? .b2() : .b2Bold())
            .foregroundColor(isDisabled ? .mdBrightBlack : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isDisabled ? .mdDim : .mdPrimary)
            )

    }
}
extension ButtonStyle where Self == PrimaryButtonStyle {
    static func primary(isDisabled: Bool) -> Self {
        PrimaryButtonStyle(isDisabled: isDisabled)
    }
}


#Preview{
    VStack{
        Button("작성하기") {}
            .buttonStyle(.primary(isDisabled: true))
        
        Button("작성하기") {}
            .buttonStyle(.primary(isDisabled: false))
    }
    .padding(.horizontal, 30)
}
