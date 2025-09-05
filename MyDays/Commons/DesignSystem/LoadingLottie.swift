//
//  LoadingLottie.swift
//  MyDays
//
//  Created by 양재현 on 9/5/25.
//

//로딩 시 보여주는 로티 애니메이션 입니다.
import SwiftUI
import Lottie

struct LoadingLottieView: UIViewRepresentable {
    
    var animationFileName: String
    let loopMode: LottieLoopMode
    
    func makeUIView(context: Context) -> UIView {
        let containerView = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        
        let animationView = LottieAnimationView(name: animationFileName)
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 100),
            animationView.heightAnchor.constraint(equalToConstant: 100),
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        return containerView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    ScrollView{}
    .overlay(
        Group {
//               if store.isLoading {
                   LoadingLottieView(animationFileName: "Loading", loopMode: .loop)
//               }
           }
    )
}
