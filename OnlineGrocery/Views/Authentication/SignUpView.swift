//
//  SignUpView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 19.08.2025.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var mainVM = MainViewModel.shared;
    
    var body: some View {
        ZStack{
            Image("bottom_bg")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            ScrollView {
                VStack{
                    Image("color_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    Text("Sign Up")
                        .font(.customFont(.gilroySemibold, fontSize: 26))
                        .foregroundStyle(Color.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)
                    
                    Text("Enter your credentials to continue")
                        .font(.customFont(.gilroySemibold, fontSize: 16))
                        .foregroundStyle(Color.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, .screenWidth * 0.1)
                    
                    LineTextField(title: "Username", placholder: "Enter your username", txt: $mainVM.txtUsername)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineTextField( title: "Email", placholder: "Enter your email address", txt: $mainVM.txtEmail, keyboardType: .emailAddress)
                        .padding(.bottom, .screenWidth * 0.07)
                    
                    LineSecureField( title: "Password", placholder: "Enter your password", txt: $mainVM.txtPassword, isShowPassword: $mainVM.isShowPassword)
                        .padding(.bottom, .screenWidth * 0.04)
                    
                    VStack {
                        Text("By continuing you agree to our")
                            .font(.customFont(.gilroyMedium, fontSize: 14))
                            .foregroundStyle(Color.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            Text("Terms of Service")
                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                .foregroundStyle(Color.primaryApp)
                            
                            Text(" and ")
                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                .foregroundStyle(Color.secondaryText)
                            
                            Text("Privacy Policy.")
                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                .foregroundStyle(Color.primaryApp)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }
                        .padding(.bottom, .screenWidth * 0.02)
                    }
                    
                    RoundButton(title: "Sing Up") {
                        mainVM.serviceCallSignUp()
                    }
                    .padding(.bottom, .screenWidth * 0.05)
                    
                    NavigationLink {
                        LoginView()
                    } label: {
                        HStack{
                            Text("Alredy have an account?")
                                .font(.customFont(.gilroySemibold, fontSize: 14))
                                .foregroundStyle(Color.primaryText)
                            
                            Text("Sign In")
                                .font(.customFont(.gilroySemibold, fontSize: 14))
                                .foregroundStyle(Color.primaryApp)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top, .topInsets + 64)
                .padding(.horizontal, 20)
                .padding(.bottom, .bottomInsets)
            }
            
            VStack {
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $mainVM.showError, content: {
            Alert(title: Text(Globs.AppName), message: Text(mainVM.errorMessage) , dismissButton: .default(Text("Ok")))
        })
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        SignUpView()
    }
}
