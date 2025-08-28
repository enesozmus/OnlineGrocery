//
//  OrderAccpetView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 27.08.2025.
//

import SwiftUI

struct OrderAccpetView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                
                Image("order_accpeted")
                    .resizable()
                    .scaledToFit()
                    .frame(width: .screenWidth * 0.7)
                    .padding(.bottom, 32)
                
                Text("Your order has been \n accepted")
                    .multilineTextAlignment(.center)
                    .font(.customFont(.gilroySemibold, fontSize: 28))
                    .foregroundStyle(Color.primaryText)
                    .padding(.bottom, 12)
                
                Text("Your items has been placcd and is on\nit’s way to being processed")
                    .multilineTextAlignment(.center)
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
                    .padding(.bottom, 12)
                
                Spacer()
                Spacer()
                
                RoundButton(title: "Track Order") {
                    //
                }
                
                Button {
                    dismiss()
                } label: {
                    Text("Back to home")
                        .font(.customFont(.gilroySemibold, fontSize: 18))
                        .foregroundStyle(Color.primaryApp)
                        .padding(.vertical, 15)
                }
                .padding(.bottom, .bottomInsets + 15)
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
}

#Preview {
    OrderAccpetView()
}
