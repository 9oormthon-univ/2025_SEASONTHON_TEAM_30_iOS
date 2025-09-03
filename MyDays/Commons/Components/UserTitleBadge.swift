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
    let color: String
    
    var body: some View {
        Text(title)
            .font(.b3BoldNickname())
            .foregroundColor(Color(hex: color))
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: color, alpha: 0.2))
            )
    }
}

#Preview {
    VStack{
        UserTitleBadge(title: "챌린저🚴", color: "A35CFF")
        UserTitleBadge(title: "하트부자💗", color: "FF83DA")
        UserTitleBadge(title: "소확행러🫰", color: "FEBC2F")
        UserTitleBadge(title: "스타터 🏁", color: "FFFFFF")
        UserTitleBadge(title: "소통왕🗽", color: "0FF2FF")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.mdSurf2)
}
