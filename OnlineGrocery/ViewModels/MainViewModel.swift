//
//  MainViewModel.swift
//  OnlineGrocery
//
//  Created by enesozmus on 17.08.2025.
//

import SwiftUI

class MainViewModel: ObservableObject {
    static var shared: MainViewModel = MainViewModel()
    
    @Published var txtUsername = ""
    @Published var txtEmail = ""
    @Published var txtPassword = ""
    @Published var isShowPassword = false
    
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var isUserLogin = false
    
    @Published var userObj: UserModel = UserModel(dict: [:])
    
    init() {
#if DEBUG
        txtUsername = "user4"
        txtEmail = "test@gmail.com"
        txtPassword = "123456"
#endif
    }
    
    //MARK: Sign In
    func serviceCallLogin(){
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        ServiceCall.post(
            parameter: ["email": txtEmail, "password": txtPassword, "dervice_token":"" ],
            path: Globs.SV_LOGIN) { responseObj in
                
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                        print(response)
                    } else {
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                        self.showError = true
                    }
                }
                
            } failure: { error in
                self.errorMessage = error?.localizedDescription ?? "Fail"
                self.showError = true
            }
    }
    
    //MARK: Sign Up
    func serviceCallSignUp(){
        
        if(txtUsername.isEmpty) {
            self.errorMessage = "please enter valid username"
            self.showError = true
            return
        }
        
        if(!txtEmail.isValidEmail) {
            self.errorMessage = "please enter valid email address"
            self.showError = true
            return
        }
        
        if(txtPassword.isEmpty) {
            self.errorMessage = "please enter valid password"
            self.showError = true
            return
        }
        
        ServiceCall.post(
            parameter: [ "username": txtUsername , "email": txtEmail, "password": txtPassword, "dervice_token":"" ],
            path: Globs.SV_SIGN_UP) { responseObj in
                if let response = responseObj as? NSDictionary {
                    if response.value(forKey: KKey.status) as? String ?? "" == "1" {
                        self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
                        print(response)
                    }else{
                        self.errorMessage = response.value(forKey: KKey.message) as? String ?? "Fail"
                        self.showError = true
                    }
                }
            } failure: { error in
                self.errorMessage = error?.localizedDescription ?? "Fail"
                self.showError = true
            }
    }
    
    //MARK: SetUserData
    func setUserData(uDict: NSDictionary) {
        Utils.UDSET(data: uDict, key: Globs.userPayload)
        Utils.UDSET(data: true, key: Globs.userLogin)
        self.userObj = UserModel(dict: uDict)
        self.isUserLogin = true
        
        self.txtUsername = ""
        self.txtEmail = ""
        self.txtPassword = ""
        self.isShowPassword = false
    }
}
