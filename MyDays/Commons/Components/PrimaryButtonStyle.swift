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
            .font(.b2())
            .foregroundColor(isDisabled ? .mdDim2 : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isDisabled ? .mdSurf2 : .mdPrimary)
            )
            .foregroundColor(isDisabled ? .mdDim : .white)

    }
}
extension ButtonStyle where Self == PrimaryButtonStyle {
    static func primary(isDisabled: Bool) -> Self {
        PrimaryButtonStyle(isDisabled: isDisabled)
    }
}


#Preview{
    Button("작성하기") {}
        .buttonStyle(.primary(isDisabled: true))
    
    Button("작성하기") {}
        .buttonStyle(.primary(isDisabled: false))
}
