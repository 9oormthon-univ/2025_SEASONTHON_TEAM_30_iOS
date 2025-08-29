//
//  Title.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - 유저 칭호 컴포넌트 입니다.

import SwiftUI

struct UserTitleBadge: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.l2())
            .foregroundColor(.mdBrightBlack)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white.shadow(.inner(color: color, radius: 20, x: 0, y: -3)))
            )
    }
}

#Preview {
    UserTitleBadge(title: "성실꾼", color: Color(hex: "FFDC68"))
}
