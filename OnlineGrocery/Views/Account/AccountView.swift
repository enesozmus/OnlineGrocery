//
//  AccountView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 25.08.2025.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 15) {
                    Image("u1")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    
                    VStack {
                        HStack {
                            Text("EnesOzmus")
                                .font(.customFont(.gilroyBold, fontSize: 20))
                                .foregroundStyle(Color.primaryText)
                            
                            Image(systemName: "pencil")
                                .foregroundStyle(Color.primaryApp)
                            
                            Spacer()
                        }
                        
                        Text("ensozmus@gmail.com")
                            .font(.customFont(.gilroyRegular, fontSize: 16))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                            .accentColor(.secondaryText)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                Divider()
                
                ScrollView {
                    LazyVStack {
                        VStack{
                            NavigationLink {
                                //MyOrdersView()
                            } label: {
                                AccountRow(title: "My Orders", icon: "a_order")
                            }
                            
                            NavigationLink {
                                //MyDetailsView()
                            } label: {
                                AccountRow(title: "My Details", icon: "a_my_detail")
                            }
                            
                            NavigationLink {
                                DeliveryAddressView()
                            } label: {
                                AccountRow(title: "Delivery Address", icon: "a_delivery_address")
                            }
                            
                            NavigationLink {
                                //PaymentMethodsView()
                            } label: {
                                AccountRow(title: "Payment Methods", icon: "paymenth_methods")
                            }
                            NavigationLink {
                                PromoCodeView()
                            } label: {
                                AccountRow(title: "Promo Codes", icon: "a_promocode")
                            }
                        }
                        
                        VStack {
                            NavigationLink {
                                //NotificationView()
                            } label: {
                                AccountRow(title: "Notifications", icon: "a_noitification")
                            }
                            
                            AccountRow(title: "Help", icon: "a_help")
                            AccountRow(title: "About", icon: "a_about")
                        }
                        
                        Button {
                            MainViewModel.shared.logout()
                        } label: {
                            ZStack {
                                Text("Log Out")
                                    .font(.customFont(.gilroySemibold, fontSize: 18))
                                    .foregroundStyle(Color.primaryApp)
                                    .multilineTextAlignment(.center)
                                
                                HStack{
                                    Spacer()
                                    Image("logout")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .padding(.trailing, 20)
                                }
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                        .background(Color(hex: "F2F3F2"))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                    }
                }
            }
            .padding(.bottom, .bottomInsets + 60)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        AccountView()
    }
}
