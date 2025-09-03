//
//  PostDetailCommentView.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 댓글 컴포넌트
import SwiftUI
import Kingfisher

struct DetailCommentView: View {
    let comment: PostDetailComment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            //<--- 유저 이미지 + 닉넴 + 칭호 + 작성시간 --->
            HStack(spacing: 10) {
                //유저 이미지
                KFImage(URL(string: comment.userimgUrl))
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
                    UserTitleBadge(title: comment.userTitle, color: comment.userTitleColor)
                    
                    //유저 닉네임
                    Text(comment.userName)
                        .font(.b1Bold())
                        .foregroundColor(.white)
                        .padding(.leading, 4)
                }
                
                Spacer()
            }
           
            //<---------------------------->
            VStack(alignment: .leading, spacing: 0) {
                //댓글 내용
                Text(comment.content.forceCharWrapping)
                    .font(.b2())
                    .foregroundColor(.white)
                    .padding(.top, 8)
                
                //작성시간
                Text(comment.createdAt)
                    .font(.b3())
                    .foregroundColor(.mdDim2)
                    .padding(.top, 8)
            }
            .padding(.leading, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    VStack {
        DetailCommentView(comment: PostDetailComment.mockComments[0])
            .padding(.horizontal, 30)
    }
    .background(.mdSurf3)
}
