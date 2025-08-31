//
//  Fonts.swift
//  MyDays
//
//  Created by 양재현 on 8/29/25.
//

//MARK: - Fonts 디자인 시스템 설정
import SwiftUI

extension UIFont {
    private static func customFont(for weight: UIFont.Weight, size: CGFloat) -> UIFont {
        let fontName: String
        switch weight {
        case .thin:
            fontName = "Pretendard-Thin"
        case .ultraLight:
            fontName = "Pretendard-ExtraLight"
        case .light:
            fontName = "Pretendard-Light"
        case .medium:
            fontName = "Pretendard-Medium"
        case .semibold:
            fontName = "Pretendard-SemiBold"
        case .bold:
            fontName = "Pretendard-Bold"
        case .heavy:
            fontName = "Pretendard-ExtraBold"
        case .black:
            fontName = "Pretendard-Black"
        default:
            fontName = "Pretendard-Regular"
        }
        
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    static func t1(_ weight: UIFont.Weight = .bold) -> UIFont {
        return customFont(for: weight, size: 24)
    }
    
    static func t2(_ weight: UIFont.Weight = .medium) -> UIFont {
        return customFont(for: weight, size: 20)
    }
    
    static func b1(_ weight: UIFont.Weight = .medium) -> UIFont {
        return customFont(for: weight, size: 16)
    }
    
    static func b2(_ weight: UIFont.Weight = .regular) -> UIFont {
        return customFont(for: weight, size: 15)
    }
    
    static func b2Bold(_ weight: UIFont.Weight = .semibold) -> UIFont {
        return customFont(for: weight, size: 15)
    }
    
    static func b3(_ weight: UIFont.Weight = .light) -> UIFont {
        return customFont(for: weight, size: 14)
    }
    
    static func b3Bold(_ weight: UIFont.Weight = .bold) -> UIFont {
        return customFont(for: weight, size: 14)
    }
    
    static func b3Light(_ weight: UIFont.Weight = .light) -> UIFont {
        return customFont(for: weight, size: 14)
    }
    
    static func l1(_ weight: UIFont.Weight = .medium) -> UIFont {
        return customFont(for: weight, size: 12)
    }
    
    static func l1Light(_ weight: UIFont.Weight = .light) -> UIFont {
        return customFont(for: weight, size: 12)
    }
    
    static func l2(_ weight: UIFont.Weight = .regular) -> UIFont {
        return customFont(for: weight, size: 14)
    }
}

//MARK: - lineHeight 설정
extension View {
    func font(_ font: UIFont) -> some View {
        
        //lineHeight 몇배인지 ex) 150% = 1.5
        let multiplier: CGFloat
        
        switch font {
        case UIFont.t1(): multiplier = 1.3
        case UIFont.t2(): multiplier = 1.3
        case UIFont.b1(): multiplier = 1.5
        case UIFont.b2(): multiplier = 1.45
        case UIFont.b2Bold(): multiplier = 1.45
        case UIFont.b3(): multiplier = 1.4
        case UIFont.b3Bold(): multiplier = 1.4
        case UIFont.b3Light(): multiplier = 1.4
        case UIFont.l1(): multiplier = 1.0
        case UIFont.l1Light(): multiplier = 1.0
        case UIFont.l2(): multiplier = 1.1
       
        default: multiplier = 1.0
        }
        
        //두 줄 사이 간격 lineSpacing
        //ex) lineHeight가 30이고 150% 이면 30 * 1.5 - 30 = 15
        let lineSpacing = ((font.lineHeight * multiplier) - font.lineHeight) / 2
        
        return self
            .font(Font(font))
//            .background(.red) //line hieght 잘 적용됐는지 확인
            .padding(.vertical, lineSpacing / 2)
//            .background(.blue) //line hieght 잘 적용됐는지 확인
            .lineSpacing(lineSpacing)
    }
}


#Preview {
    VStack(spacing:0) {
        Text("T1")
            .font(.t1())
        Text("T2")
            .font(.t2())
        Text("B1")
            .font(.b1())
        Text("B2")
            .font(.b2())
        Text("B2-Bold")
            .font(.b2Bold())
        Text("B3")
            .font(.b3())
        Text("B3-Bold")
            .font(.b3Bold())
        Text("B3-light")
            .font(.b3Light())
        Text("L1")
            .font(.l1())
        Text("L1-light")
            .font(.l1Light())
        Text("L2")
            .font(.l2())
    }
    //폰트 적용됐는지 확인 기능
//    .onAppear{
//        for family in UIFont.familyNames.sorted() {
//            print("Family: \(family)")
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print("    Font: \(name)")
//            }
//        }
//    }
}
