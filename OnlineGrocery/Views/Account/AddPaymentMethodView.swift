//
//  AddPaymentMethodView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 27.08.2025.
//

import SwiftUI

struct AddPaymentMethodView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var payVM = PaymentViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 15) {
                    LineTextField(
                        title: "Name",
                        placholder: "Enter you name" ,
                        txt: $payVM.txtName
                    )
                    
                    LineTextField(
                        title: "Card Number",
                        placholder: "Enter card number",
                        txt: $payVM.txtCardNumber,
                        keyboardType: .numberPad
                    )
                    
                    HStack{
                        LineTextField(
                            title: "MM",
                            placholder: "Enter Month" ,
                            txt: $payVM.txtCardMonth,
                            keyboardType: .numberPad
                        )
                        
                        LineTextField(
                            title: "YYYY",
                            placholder: "Enter Year" ,
                            txt: $payVM.txtCardYear,
                            keyboardType: .numberPad
                        )
                    }
                    
                    RoundButton(title:  "Add Payment Method") {
                        payVM.serviceCallAdd {
                            dismiss()
                        }
                    }
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
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
                    
                    Text("Add Payment Method")
                        .font(.customFont(.gilroyBold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                
                Spacer()
            }
        }
        .alert(isPresented: $payVM.showError) {
            Alert(
                title: Text(Globs.AppName),
                message: Text(payVM.errorMessage),
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
    AddPaymentMethodView()
}
