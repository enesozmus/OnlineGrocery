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
    
    init() {
        #if DEBUG
        txtUsername = "user4"
        txtEmail = "test@gmail.com"
        txtPassword = "123456"
        #endif
    }
    
    //MARK: ServiceCall
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
                        //self.setUserData(uDict: response.value(forKey: KKey.payload) as? NSDictionary ?? [:])
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
}
