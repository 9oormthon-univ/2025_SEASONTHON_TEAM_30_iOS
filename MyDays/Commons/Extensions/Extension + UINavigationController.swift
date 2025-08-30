//
//  Extension + UINavigationController.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 뒤로가기를 스와이프로 할 수 있는 기능입니다
import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1  // 첫 화면에서는 스와이프 뒤로 가기 비활성화
    }
}
