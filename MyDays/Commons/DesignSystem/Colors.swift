//
//  Colors.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - Color 디자인 시스템 설정
import SwiftUI

extension ShapeStyle where Self == Color {
    
    init(hex: String, alpha: Double = 1.0) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedHex.hasPrefix("#") {
            cleanedHex.remove(at: cleanedHex.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    //피그마 Color 네임명을 그대로 따라갔는데 추후 수정 가능
    static var mdPrimary: Color { Color(hex: "#FF544E") }
    static var mdPricon: Color { Color(hex: "#FF8581") }
    static var mdPricon2: Color { Color(hex: "#FFCAC8") }
    static var mdPricon3: Color { Color(hex: "#FFEBEA") }
    
    static var mdSecondary: Color { Color(hex: "#6A7BFF") }
    static var mdSeconCon: Color { Color(hex: "#909DFF") }
    
    static var mdSurf1: Color { Color(hex: "#F5F5F5") }
    static var mdSurf2: Color { Color(hex: "#ECEEF2") }
    
    static var mdDim: Color { Color(hex: "#919191") }
    static var mdDim2: Color { Color(hex: "#767676") }
    
    static var mdBrightBlack: Color { Color(hex: "#111111") }
}


#Preview {
    let colors: [Color] = [
        .mdPrimary, .mdPricon, .mdPricon2, .mdPricon3,
        .mdSecondary, .mdSeconCon,
        .mdSurf1, .mdSurf2,
        .mdDim, .mdDim2,
        .mdBrightBlack
    ]
    
    return ScrollView {
        VStack {
            ForEach(colors, id: \.self) { color in
                Rectangle()
                    .fill(color)
                    .frame(width: 300, height: 50)
            }
        }
    }
}
