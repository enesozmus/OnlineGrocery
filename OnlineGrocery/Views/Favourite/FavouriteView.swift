//
//  FavouriteView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 24.08.2025.
//

import SwiftUI

struct FavouriteView: View {
    @StateObject var favVM = FavouriteViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    ForEach( favVM.listArr , id: \.id, content: { fObj in
                        FavouriteRow(fObj: fObj)
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Favorites")
                        .font(.customFont(.gilroyBold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                Spacer()
                
                RoundButton(title: "Add All To Cart")
                    .padding(.horizontal, 20)
                    .padding(.bottom, .bottomInsets + 80)
            }
        }
        .onAppear{
            favVM.serviceCallList()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FavouriteView()
}
