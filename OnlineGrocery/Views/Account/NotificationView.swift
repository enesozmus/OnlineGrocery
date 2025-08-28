//
//  NotificationView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 28.08.2025.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var notiVM = NotificationViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(notiVM.listArr , id: \.id, content: { nObj in
                        VStack {
                            HStack {
                                Text(nObj.title)
                                    .font(.customFont(.gilroyBold, fontSize: 14))
                                    .foregroundStyle(Color.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(nObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.customFont(.gilroyRegular, fontSize: 12))
                                    .foregroundStyle(Color.secondaryText)
                            }
                            
                            Text(nObj.message)
                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                .foregroundStyle(Color.primaryText)
                                .multilineTextAlignment(.leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(15)
                        .background(nObj.isRead == 1 ? Color.placeholder : Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    
                    Spacer()
                    
                    Text("Notification")
                        .font(.customFont(.gilroyBold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                    
                    Button {
                        notiVM.serviceCallReadAll()
                    } label: {
                        Text("Read All")
                            .font(.customFont(.gilroyBold, fontSize: 16))
                            .foregroundStyle(Color.primaryApp)
                    }
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2)
                
                Spacer()
            }
        }
        .alert(isPresented: $notiVM.showError) {
            Alert(
                title: Text(Globs.AppName),
                message: Text(notiVM.errorMessage),
                dismissButton: .default(Text("Ok"))
            )
        }
        .navigationTitle("")
        .toolbarVisibility(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NotificationView()
}
