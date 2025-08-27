//
//  CheckoutView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 24.08.2025.
//

import SwiftUI

struct CheckoutView: View {
    
    @Binding var isShow: Bool
    @StateObject var cartVM = CartViewModel.shared
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                headerView
                
                checkoutOptionsSection
                
                orderSummarySection
                
                termsAndConditionsSection
                
                placeOrderButton
            }
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(20, corner: [.topLeft, .topRight])
        }
    }
}

extension CheckoutView {
    // MARK: - Header View
    var headerView: some View {
        VStack {
            HStack {
                Text("Checkout")
                    .font(.customFont(.gilroyBold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
                Button {
                    $isShow.wrappedValue = false
                } label: {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
            }
            .padding(.top, 30)
            Divider()
            
        }
    }
    
    // MARK: - Checkout Options
    var checkoutOptionsSection: some View {
        VStack {
            HStack {
                Text("Delivery Type")
                    .font(.customFont(.gilroySemibold, fontSize: 18))
                    .foregroundStyle(Color.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Picker("", selection: $cartVM.deliveryType) {
                    Text("Delivery").tag(1)
                    Text("Collection").tag(2)
                }
                .pickerStyle(.segmented)
                .frame(width: 180)
            }
            
            Divider()
            
            if cartVM.deliveryType == 1 {
                NavigationLink {
                    DeliveryAddressView(isPicker: true, didSelect: { aObj in
                        cartVM.deliverObj = aObj
                    })
                } label: {
                    HStack {
                        Text("Delivery")
                            .font(.customFont(.gilroySemibold, fontSize: 18))
                            .foregroundStyle(Color.secondaryText)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Text(cartVM.deliverObj?.name ?? "Select Method")
                            .font(.customFont(.gilroySemibold, fontSize: 18))
                            .foregroundStyle(Color.primaryText)
                            .frame(height: 46)
                        
                        Image("next")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.primaryText)
                    }
                }
                Divider()
            }
            
            HStack {
                Text("Payment Type")
                    .font(.customFont(.gilroySemibold, fontSize: 18))
                    .foregroundStyle(Color.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Picker("", selection: $cartVM.paymentType) {
                    Text("COD").tag(1)
                    Text("Online").tag(2)
                }
                .pickerStyle(.segmented)
                .frame(width: 150)
            }
            
            Divider()
            
            if cartVM.paymentType == 2 {
                NavigationLink {
                    //                    PaymentMethodsView(isPicker: true, didSelect: { pObj in
                    //                        cartVM.paymentObj = pObj
                    //                    })
                } label: {
                    HStack {
                        Text("Payment")
                            .font(.customFont(.gilroySemibold, fontSize: 18))
                            .foregroundStyle(Color.secondaryText)
                            .frame(height: 46)
                        
                        Spacer()
                        
                        Image("master")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 20)
                        
                        Text(cartVM.paymentObj?.cardNumber ?? "Select")
                            .font(.customFont(.gilroySemibold, fontSize: 18))
                            .foregroundStyle(Color.primaryText)
                            .frame(height: 46)
                        
                        Image("next")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.primaryText)
                    }
                }
                Divider()
            }
            
            NavigationLink {
                PromoCodeView(isPicker: true, didSelect: { pObj in
                    cartVM.promoObj = pObj
                })
            } label: {
                HStack {
                    Text("Promo Code")
                        .font(.customFont(.gilroySemibold, fontSize: 18))
                        .foregroundStyle(Color.secondaryText)
                        .frame(height: 46)
                    
                    Spacer()
                    
                    Text(cartVM.promoObj?.code ?? "Pick Discount")
                        .font(.customFont(.gilroySemibold, fontSize: 18))
                        .foregroundStyle(Color.primaryText)
                        .frame(height: 46)
                    
                    Image("next")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.primaryText)
                }
            }
            Divider()
        }
    }
    
    // MARK: - Subviews
    // MARK: - Order Summary
    var orderSummarySection: some View {
        VStack {
            HStack {
                Text("Totat")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
                
                Spacer()
                
                Text("$ \(cartVM.total)")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
            }
            
            HStack {
                Text("Delivery Cost")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
                
                Spacer()
                
                Text("+ $ \(cartVM.deliverPriceAmount)")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
            }
            
            HStack {
                Text("Discount")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.secondaryText)
                
                Spacer()
                
                Text("- $ \(cartVM.discountAmount)")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(.red)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
    }
    
    // MARK: - Final Total
    var finalTotalView: some View {
        VStack {
            HStack {
                Text("Final Total")
                    .font(.customFont(.gilroySemibold, fontSize: 18))
                    .foregroundStyle(Color.secondaryText)
                    .frame(height: 46)
                
                Spacer()
                
                Text("$\(cartVM.userPayAmount)")
                    .font(.customFont(.gilroySemibold, fontSize: 18))
                    .foregroundStyle(Color.primaryText)
                    .frame(height: 46)
                
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(Color.primaryText)
            }
            Divider()
        }
    }
    
    // MARK: - Terms and Conditions
    var termsAndConditionsSection: some View {
        VStack(alignment: .leading) {
            Text("By continuing you agree to our")
                .font(.customFont(.gilroySemibold, fontSize: 14))
                .foregroundStyle(Color.secondaryText)
            
            HStack {
                Text("Terms of Service")
                    .font(.customFont(.gilroySemibold, fontSize: 14))
                    .foregroundStyle(Color.primaryText)
                
                Text(" and ")
                    .font(.customFont(.gilroySemibold, fontSize: 14))
                    .foregroundStyle(Color.secondaryText)
                
                Text("Privacy Policy.")
                    .font(.customFont(.gilroySemibold, fontSize: 14))
                    .foregroundStyle(Color.primaryText)
            }
        }
        .padding(.vertical, .screenWidth * 0.03)
    }
    
    // MARK: - Place Order Button
    var placeOrderButton: some View {
        RoundButton(title: "Place Order") {
            cartVM.serviceCallOrderPlace()
        }
        .padding(.bottom, .bottomInsets + 70)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var isShow = false
        
        var body: some View {
            NavigationStack {
                CheckoutView(isShow: $isShow)
            }
        }
    }
    
    return PreviewWrapper()
}
