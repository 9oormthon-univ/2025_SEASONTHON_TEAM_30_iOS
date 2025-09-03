//
//  SkeletonHomePost.swift
//  MyDays
//
//  Created by 양재현 on 9/2/25.
//

//MARK: - 스켈레톤 홈 게시물 컴포넌트 (밑에 프리뷰처럼 사용 !!)

import SwiftUI
import Kingfisher

struct SkeletonHomePost: View {
//    let totalWidth = UIScreen.main.bounds.width - 30
    let color: Color = Color.black.opacity(0.3) //스켈레톤 색깔
    
    let size = UIScreen.main.bounds.width - 48
    
    var body: some View {
        VStack(spacing: 0) {
            //<--- 유저 이미지 + 칭호 + 닉넴 --->
            HStack(spacing: 10) {
                //유저 이미지 부분
                Circle()
                    .fill(color)
                    .frame(width: 42, height: 42)
                
                VStack(alignment: .leading) {
                    //유저 칭호 부분
                    Capsule()
                        .fill(color)
                        .frame(width: size / 6, height: 12)

                    //유저 닉네임 부분
                    Capsule()
                        .fill(color)
                        .frame(width: size / 5, height: 12)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            //<----------------------------------->
            
            //<---- 작성글 + 작성시간 + 이미지 + 좋아요 + 댓글 ---->
            VStack(alignment: .leading, spacing: 0) {
                //작성글 부분
                let contentSize = 15.0
                VStack(alignment: .leading, spacing: 10) {
                    Capsule()
                        .fill(color)
                        .frame(width: size, height: contentSize)
                    
                    Capsule()
                        .fill(color)
                        .frame(width: size, height: contentSize)
                    
                    Capsule()
                        .fill(color)
                        .frame(width: size - 50, height: contentSize)
                }
                
                //원래 이미지가 있어야 할 곳
                RoundedRectangle(cornerRadius: 12)
                    .fill(color)
                    .frame(width: size, height: size)
                    .padding(.top, 10)
                
                //좋아요, 댓글 부분
                Capsule()
                    .fill(color)
                    .frame(width: size / 3, height: contentSize)
                    .padding(.top, 10)
            }
            .padding(.top, 5)
            //<---------------------------------->
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    VStack{
        //<----- 이 부분 사용 ---------------------------->
        SkeletonHomePost()
            .skeleton(isRedacted: true)
            .padding(.horizontal, 30)
        //<----- 이 부분 사용 ---------------------------->
    }
    .background(.mdSurf2)
}
