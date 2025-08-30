//
//  Extension + String.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 단어 단위로 줄바꿈되지 않게 해주는 기능입니다.
import Foundation
import SwiftUI

extension String {
    var forceCharWrapping: Self {
        self.map({ String($0) }).joined(separator: "\u{200B}") // 200B: 가로폭 없는 공백문자
    }
}
