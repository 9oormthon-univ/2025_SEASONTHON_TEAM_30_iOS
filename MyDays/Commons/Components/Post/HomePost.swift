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
    @State var hapticFeedback = false //좋아요 햅틱 피드백
    
    var body: some View {
        VStack(spacing: 0) {
            //<--- 유저 이미지 + 칭호 + 닉넴 --->
            HStack(spacing: 10) {
                //유저 이미지
                KFImage(URL(string: post.userimgUrl))
                    .placeholder { // 로딩 중
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 42, height: 42)
                    .clipped()
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 6) {
                    //유저 칭호
                    UserTitleBadge(title: post.userTitle, color: post.userTitleColor)
                    
                    //유저 닉네임
                    Text(post.userName)
                        .font(.b1Bold())
                        .foregroundColor(.white)
                        .padding(.leading, 4)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            //<----------------------------------->
            
            //<---- 작성글 + 작성시간 + 이미지 + 좋아요 + 댓글 ---->
            VStack(alignment: .leading, spacing: 0) {
                //작성글
                Text(post.content.forceCharWrapping)
                    .lineLimit(3) //3줄이상은 ...로 표시
                    .font(.b3())
                    .foregroundColor(.white)
                    .padding(.horizontal, 4)
                
                //작성시간
                Text(post.createdAt)
                    .font(.b3())
                    .foregroundColor(.mdDim2)
                    .padding(.horizontal, 4)
                    .padding(.top, 8)
                
                //작성글 이미지
                let size = UIScreen.main.bounds.width - 48
                
                KFImage(URL(string: post.contentImgUrl))
                    .placeholder { // 로딩 중
                        ProgressView()
                    }
                    .cancelOnDisappear(true)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .clipShape( RoundedRectangle(cornerRadius: 12))
                    .padding(.top, 8)
                
                //좋아요, 댓글
                HStack(spacing: 0) {
                    Button(action: {
                        hapticFeedback.toggle() //햅틱 피드백
                        onLike()
                    }) {
                        Image(post.isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 18)
                    }
                    .sensoryFeedback(.impact(weight: .light), trigger: hapticFeedback)
                    //햅틱 피드백
                    
                    Text("\(post.likeCount)")
                        .font(.b3())
                        .foregroundColor(.white)
                        .padding(.leading, 7)
                    
                    Image("comment")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                    
                    Text("\(post.commentCount)")
                        .font(.b3())
                        .foregroundColor(.white)
                        .padding(.leading, 7)
                }
                .padding(.leading, 8)
                .padding(.top, 16)
            }
            .padding(.top, 8)
//            .padding(.horizontal, 20)
            //<---------------------------------->
        }
        .padding(.bottom, 25)
    }
}

#Preview {
    VStack{
        //<----- 이 부분 사용 ---------------------------->
        HomePostView(post: Post.mockPosts[0], onLike: {})
            .padding(.horizontal, 30)
        //<----- 이 부분 사용 ---------------------------->
    }
    .background(.mdSurf2)
}
