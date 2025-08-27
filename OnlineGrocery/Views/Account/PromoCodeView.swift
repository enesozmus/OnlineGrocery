//
//  PromoCodeView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 26.08.2025.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var promoVM = PromoCodeViewModel.shared
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: PromoCodeModel) -> () )?
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(promoVM.listArr, id: \.id, content: { pObj in
                        VStack {
                            HStack {
                                Text(pObj.title)
                                    .font(.customFont(.gilroyBold, fontSize: 14))
                                    .foregroundStyle(Color.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                Text(pObj.code)
                                    .font(.customFont(.gilroyBold, fontSize: 15))
                                    .foregroundStyle(Color.primaryApp)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Color.secondaryText.opacity(0.3))
                                    .cornerRadius(5)
                            }
                            
                            Text(pObj.description)
                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                .foregroundStyle(Color.secondaryText)
                                .multilineTextAlignment(.leading)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            HStack {
                                Text("Expiry Date:")
                                    .font(.customFont(.gilroyBold, fontSize: 14))
                                    .foregroundStyle(Color.primaryText)
                                    .padding(.vertical, 8)
                                
                                Text(pObj.endDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.customFont(.gilroyBold, fontSize: 12))
                                    .foregroundStyle(Color.secondaryText)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
                        .onTapGesture {
                            if(isPicker) {
                                dismiss()
                                didSelect?(pObj)
                            }
                        }
                    })
                }
                .padding(20)
                .padding(.top, .topInsets + 46)
                .padding(.bottom, .bottomInsets + 60)
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
                    
                    Text("Promo Code")
                        .font(.customFont(.gilroyBold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2), radius: 2)
                
                Spacer()
            }
        }
        .onAppear {
            
        }
        .navigationTitle("")
        .toolbarVisibility(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    PromoCodeView()
}
