//
//  OnlineGroceryApp.swift
//  OnlineGrocery
//
//  Created by enesozmus on 16.08.2025.
//

import SwiftUI

@main
struct OnlineGroceryApp: App {
    
    @StateObject var mainVM = MainViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if mainVM.isUserLogin {
                    MainTabView()
                } else {
                    WelcomeView()
                }
            }
        }
    }
}
