//
//  LoginView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 16.08.2025.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var loginVM = MainViewModel.shared
    
    var body: some View {
        ZStack {
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack {
                Image("color_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
                    .padding(.bottom, .screenWidth * 0.1)
                
                Text("Loging")
                    .font(.customFont(.gilroySemibold, fontSize: 26))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 4)
                
                Text("Enter your emails and password")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, .screenWidth * 0.1)
                
                
                LineTextField(
                    title: "Email",
                    placholder: "Enter your email address",
                    txt: $loginVM.txtEmail,
                    keyboardType: .emailAddress
                )
                .padding(.bottom, .screenWidth * 0.07)
                
                LineSecureField(
                    title: "Password",
                    placholder: "Enter your password",
                    txt: $loginVM.txtPassword,
                    isShowPassword: $loginVM.isShowPassword
                )
                .padding(.bottom, .screenWidth * 0.02)
                
                
                NavigationLink {
                    //
                } label: {
                    Text("Forgot Password?")
                        .font(.customFont(.gilroyMedium, fontSize: 14))
                        .foregroundStyle(Color.primaryText)
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, .screenWidth * 0.03)
                
                
                RoundButton(title: "Log In") {
                    loginVM.serviceCallLogin()
                }
                .padding(.bottom, .screenWidth * 0.05)
                
                
                NavigationLink {
                    //
                } label: {
                    HStack{
                        Text("Don’t have an account?")
                            .font(.customFont(.gilroySemibold, fontSize: 14))
                            .foregroundStyle(Color.primaryText)
                        
                        Text("Signup")
                            .font(.customFont(.gilroySemibold, fontSize: 14))
                            .foregroundStyle(Color.primaryApp)
                    }
                }
                
                Spacer()
            }
            .padding(.top, .topInsets + 64)
            .padding(.horizontal, 20)
            .padding(.bottom, .bottomInsets)
            
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
                }
                
                Spacer()
                
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
        }
        .alert(isPresented: $loginVM.showError) {
            Alert(title: Text(Globs.AppName), message: Text( loginVM.errorMessage ), dismissButton: .default(Text("Ok")))
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
