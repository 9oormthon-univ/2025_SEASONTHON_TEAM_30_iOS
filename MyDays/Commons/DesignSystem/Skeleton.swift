//
//  Skeleton.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스켈레톤 모디파이어 입니다.
import SwiftUI

extension View {
    func skeleton(isRedacted: Bool) -> some View {
        self
            .modifier(SkeletonModifier(isRedacted: isRedacted))
    }
}

struct SkeletonModifier: ViewModifier {
    // 레드액트(placeholder) 효과를 켤지 여부
    var isRedacted: Bool
    // 애니메이션 상태를 저장 (true면 스켈레톤이 움직이는 중)
    @State var isAnimating: Bool = false
    
    func body(content: Content) -> some View {
        content
            // isRedacted가 true면 SwiftUI 기본 placeholder 스타일 적용
            .redacted(reason: isRedacted ? .placeholder : [])
            .overlay { // 레이아웃 위에 덮어씌울 뷰
                if isRedacted { // 레드액트가 활성화되었을 때만
                    GeometryReader { // 부모 뷰의 크기를 알아내기 위해 사용
                        let size = $0.size
                        // 스켈레톤 폭: 전체의 절반
                        let skeletonWidth = size.width / 2
                        
                        // blur 반경 계산
                        let blurRadius = max(skeletonWidth / 2, 30)
                        let blurDimmer = blurRadius * 2
                        
                        // 애니메이션 시작과 끝 위치 계산
                        let minX = -(skeletonWidth + blurDimmer)
                        let maxX = size.width + skeletonWidth + blurDimmer
                        
                        Rectangle() // 스켈레톤 모양
                            // 다크모드면 흰색, 라이트모드면 검은색
//                            .fill(scheme == .dark ? .white : .black)
                            .fill(.white)
                            // 스켈레톤 크기 설정 (너비는 절반, 높이는 부모 두배)
                            .frame(width: skeletonWidth, height: size.height * 2)
                            .frame(height: size.height) // 부모 높이에 맞춤
                            .blur(radius: blurRadius) // blur 처리
                            .rotationEffect(.init(degrees: rotation)) // 살짝 기울이기
                            // x축 이동: isAnimating이 true면 maxX, 아니면 minX
                            .offset(x: isAnimating ? maxX : minX)
                    }
                    .mask { // content 모양으로 마스크 처리
                        content
                            .redacted(reason: .placeholder)
                    }
                    .blendMode(.softLight) // 부드러운 합성 모드
                    .task { // 뷰가 나타날 때 실행
                        guard !isAnimating else { return }
                        // 애니메이션 시작
                        withAnimation(shimmerAnimation) {
                            isAnimating = true
                        }
                    }
                    .onDisappear { // 뷰가 사라질 때
                        isAnimating = false
                    }
                    .transaction { // 애니메이션 트랜잭션 설정
                        if $0.animation != shimmerAnimation {
                            // 기본 애니메이션 제거
                            $0.animation = .none
                        }
                    }
                }
            }
    }
    
    // 스켈레톤 기울기
    var rotation: Double {
        return 5
    }

    // 스켈레톤 좌우 이동 애니메이션
    var shimmerAnimation: Animation {
        .easeOut(duration: 1.5) // 1.5초 동안 easeOut
        .repeatForever(autoreverses: false) // 반복, 되돌아가지 않음
    }
}
