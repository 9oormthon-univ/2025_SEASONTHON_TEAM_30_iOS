//
//  Shadows.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//
//MARK: - Shadows 디자인 시스템 설정
import SwiftUI

extension View {
    func dropshadow1(color: Color = Color(hex: "000000", alpha: 0.04), radius: CGFloat = 4, x: CGFloat = 0, y: CGFloat = 2) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y)
    }
    
    func dropshadow2(color: Color = Color(hex: "000000", alpha: 0.04), radius: CGFloat = 4, x: CGFloat = 2, y: CGFloat = -2) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y)
    }
    
    func dropshadow3(color: Color = Color(hex: "000000", alpha: 0.04), radius: CGFloat = 20, x: CGFloat = 4, y: CGFloat = 4) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y)
    }
}

extension Shape {
    func innerShadow(color: Color) -> some View {
        self.fill(.white.shadow(.inner(color: color, radius: 20, x: 0, y: -3)))
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        VStack(spacing: 20) {
            Rectangle()
                .fill(.white)
                .frame(width: 300, height: 50)
                .dropshadow1()
            
            Rectangle()
                .fill(.white)
                .frame(width: 300, height: 50)
                .dropshadow2()
            
            Rectangle()
                .fill(.white)
                .frame(width: 300, height: 50)
                .dropshadow3()
            
            Rectangle()
                .innerShadow(color: .pink)
                .frame(width: 300, height: 50)
               
        }
    }
}
