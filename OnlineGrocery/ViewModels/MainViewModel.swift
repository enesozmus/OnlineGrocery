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
}
