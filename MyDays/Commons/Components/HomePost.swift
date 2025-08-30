//
//  HomePost.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 홈 게시물 컴포넌트 (밑에 프리뷰처럼 사용 !!)

import SwiftUI
import Kingfisher

struct HomePostView: View {
    let post: Post
    let onLike: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            //<--- 이미지 + 닉넴 + 칭호 + 작성시간 --->
            HStack(spacing: 10) {
                //유저 이미지
                KFImage(URL(string: post.userimgUrl))
                    .placeholder { // 로딩 중
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 42)
                    .clipped()
                    .clipShape(Circle())

                //유저 닉네임
                Text(post.userName)
                    .font(.b3())
                    .foregroundColor(.black)
                
                //유저 칭호
                UserTitleBadge(title: post.userTitle, color: Color(hex: post.userTitleColor))
                
                Circle()
                    .frame(width: 4, height: 4)
                    .foregroundColor(.mdDim2)
                
                //작성시간
                Text(post.createdAt)
                    .font(.b3())
                    .foregroundColor(.mdDim2)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            //<----------------------------------->
            
            //<---- 작성글 + 이미지 + 좋아요 + 댓글 ---->
            VStack(alignment: .leading, spacing: 0) {
                //작성글
                Text(post.content.forceCharWrapping)
                    .lineLimit(3) //3줄이상은 ...로 표시
                    .font(.b2())
                    .foregroundColor(.black)
                
                //작성글 이미지
                KFImage(URL(string: post.contentImgUrl))
                    .placeholder { // 로딩 중
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: UIScreen.main.bounds.width - 109)
                    .clipped()
                    .clipShape( RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 10)
                
                //좋아요, 댓글
                HStack(spacing: 0) {
                    Image("heart")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 20, height: 18)
                        .foregroundColor(.mdBrightBlack)
                        .onTapGesture{
                            onLike()
                        }
                    
                    Text("\(post.likeCount)")
                        .font(.b3())
                        .foregroundColor(.mdBrightBlack)
                        .padding(.leading, 7)
                    
                    Image("comment")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.mdBrightBlack)
                        .padding(.leading, 10)
                    
                    Text("\(post.commentCount)")
                        .font(.b3())
                        .foregroundColor(.mdBrightBlack)
                        .padding(.leading, 7)
                }
                .padding(.top, 20)
            }
            .padding(.leading, 49)
            //<---------------------------------->
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    HomePostView(post: Post.mockPosts[0], onLike: {})
        .padding(.horizontal, 30)
}
