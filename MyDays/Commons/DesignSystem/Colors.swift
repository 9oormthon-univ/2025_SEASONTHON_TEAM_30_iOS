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
    static var mdPrimary: Color { Color(hex: "#5FF1F9") }
    static var mdPrimaryCon: Color { Color(hex: "#A1FAFF") }
    static var mdPrimaryText: Color { Color(hex: "#00888F") }
    
    static var mdSecon: Color { Color(hex: "#60CE38") }
    static var mdBrightSurf: Color { Color(hex: "#F5F5FD") }
    
    static var mdDim: Color { Color(hex: "#919191") }
    static var mdDim2: Color { Color(hex: "#767676") }
    static var mdBrightBlack: Color { Color(hex: "#111111") }
    
    static var mdSurf2: Color { Color(hex: "#1E1F24") }
    static var mdSurf3: Color { Color(hex: "#292B32") }
    static var mdSurf4: Color { Color(hex: "#3F4045") }
    
    static var mdError: Color { Color(hex: "#E30000") }
    static var mdNavi1: Color { Color(hex: "#151617") }
    static var mdNavi2: Color { Color(hex: "#3F4045") }
    static var mdNavi3: Color { Color(hex: "#5B5D65") }
}


#Preview {
    let colors: [Color] = [
        .mdPrimary, .mdPrimaryCon, .mdPrimaryText,
        .mdSecon, .mdBrightSurf,
        .mdDim, .mdDim2, .mdBrightBlack,
        .mdSurf2, .mdSurf3, .mdSurf4,
        .mdError, .mdNavi1, .mdNavi2, .mdNavi3
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
