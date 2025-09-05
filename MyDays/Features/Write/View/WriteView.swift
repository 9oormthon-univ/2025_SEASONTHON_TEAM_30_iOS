//
//  WriteView.swift
//  MyDays
//
//  Created by 양재현 on 8/30/25.
//

//MARK: - 미션 작성 화면
import PhotosUI
import SwiftUI

struct WriteView: View {
    @StateObject var vm: WriteViewModel = WriteViewModel()
    @FocusState var isFocused: Bool //미션 작성 텍스트 에디터 포커스
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        ZStack {
            Color.mdSurf2.ignoresSafeArea() //로딩중에도 백그라운드 주기위해서
            
            ScrollView(showsIndicators: false) {
                if let mission = vm.mission {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(mission.text.forceCharWrapping)
                            .font(.t2())
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        //텍스트 에디터
                        TextEditor(text: $vm.text)
                            .focused($isFocused)
                            .textEditorStyle(text: $vm.text, placeholder: "내용을 입력하세요")
                            .padding(.top, 30)
                        
                        //선택된 이미지
                        if let selectedImage = vm.selectedImage {
                            SelectedImageView(uiImage: selectedImage, onClose: {
                                vm.closeImage()
                            })
                            .padding(.top, 30)
                        }
                        
                        //사진 추가 박스
                        else {
                            PhotosPicker(selection: $vm.selectedItem,
                                         matching: .images) {
                                AddPhotoBox()
                                    .padding(.top, 30)
                            }
                        }
                        
                        //작성하기 버튼
                        Button(vm.isLoading ? "" : "작성하기") { vm.postMission() }
                            .buttonStyle(.primary(isDisabled: vm.disabled))
                            .disabled(vm.disabled)
                            .overlay {
                                //TODO: 이거 말고 로딩 로티 .. ?
                                if vm.isLoading {
                                    ProgressView()
                                }
                            }
                            .padding(.top, 30)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 54 + 25) //탭뷰 height 는 54임
                }
            }
        }
        .padding(.top, -8) //스크롤뷰, 헤더간 간격
//        .background(.mdSurf2)
        .onTapGesture {
            isFocused = false //다른데 터치하면 포커스 풀리기
        }
        .toolbar(.hidden, for: .navigationBar)
        //헤더뷰
        .safeAreaInset(edge: .top, alignment: .center, spacing: nil) {
            WriteHeaderView(onBack: { nav.popLast() })
        }
        //작성 완료 시 로딩 로티
        .overlay(
            Group {
                   if vm.isLoading {
                       LoadingLottieView(animationFileName: "Loading", loopMode: .loop)
                   }
               }
        )
        //사진 변경 감지해서 로드
        .onChange(of: vm.selectedItem) { _, _ in
            vm.loadTransferable()
        }
        //작성 완료 감지해서 디테일 페이지로 이동
        .onChange(of: vm.navigateToPostId) { _, newValue in
            if let postId = newValue {
                nav.popToRoot() //작성 화면 나오면서
                nav.push(AppRoute.postDetail(postId: postId))
                vm.navigateToPostId = nil // 한 번 쓰고 초기화
            }
        }
        //작성 화면 페이지 조회 시
        .onAppear {
            vm.getWritePage()
        }
    }
}
//MARK: - 헤더
struct WriteHeaderView: View {
    let onBack: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            //뒤로가기
            Image("back")
                .onTapGesture {
                    onBack()
                }
                .padding(.horizontal, 30)
            Spacer()
        }
        .overlay(
            Text("챌린지 작성")
                .font(.b1())
                .foregroundColor(.white)
        )
        .padding(.top, 10)
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(.mdSurf2)
    }
}


//MARK: - 텍스트 에디터 모디파이어
struct TextEditorStyleModifier: ViewModifier {
    @Binding var text: String
    var placeholder: String
    
    func body(content: Content) -> some View {
        content
            .accentColor(.white)
            .foregroundColor(.white)
            .padding(20)
            .contentMargins(.leading, -5) //딱맞네 이렇게 두니
            .contentMargins(.top, -8)
            .contentMargins(.bottom, 8)
        
            .frame(minHeight: 117)
            .scrollContentBackground(.hidden) //기본 배경 제거
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.mdSurf3)
            )
        //placeholder
            .overlay(alignment: .topLeading) {
                if text == "" {
                    Text(placeholder)
                        .font(.b2())
                        .foregroundColor(.mdBrightSurf)
                        .padding(.leading, 20)
                        .padding(.top, 20)
                }
            }
        //최대글자수 0/300
            .overlay(alignment: .bottomTrailing) {
                HStack(spacing: 0) {
                    Text("\(text.count)")
                        .foregroundColor(text == "" ? .mdDim : .white)
                    
                    Text("/300")
                        .foregroundColor(.mdDim)
                }
                .font(.b2())
                .padding(.trailing, 20.5)
                .padding(.bottom, 14)
            }
        //300자 초과하면 막기
            .onChange(of: text) { _, newValue in
                if newValue.count > 300 {
                    text = String(newValue.prefix(300))
                }
            }
    }
    
}

extension View {
    func textEditorStyle(text: Binding<String>, placeholder: String) -> some View {
        self.modifier(TextEditorStyleModifier(text: text, placeholder: placeholder))
    }
}
//MARK: - 선택된 이미지
struct SelectedImageView: View {
    let uiImage: UIImage
    let onClose: () -> Void
    
    var body: some View {
        let size = UIScreen.main.bounds.width - 60
        
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .clipped()
            .clipShape( RoundedRectangle(cornerRadius: 12))
            .overlay(alignment: .topTrailing){
                Image("close.circle")
                    .onTapGesture {
                        onClose()
                    }
                    .padding(20)
            }
    }
}

//MARK: - 사진 추가 박스
struct AddPhotoBox: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("사진을 추가해주세요")
                .font(.b1())
                .foregroundColor(.white)
            
            Image("plus.circle")
                .padding(.top, 10)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 26.5)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.mdSurf3)
        )
        
    }
}

#Preview {
    NavigationStack{
        WriteView()
    }
}
