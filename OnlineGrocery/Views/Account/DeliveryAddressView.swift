//
//  DeliveryAddressView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 25.08.2025.
//

import SwiftUI

struct DeliveryAddressView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var addressVM = DeliveryAddressViewModel.shared
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: AddressModel) -> () )?
    
    var body: some View {
        ZStack {
            addressListView
            VStack {
                headerView
                Spacer()
            }
        }
        .onAppear{
            
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
    
    // MARK: - Subviews (Computed Properties)
    private var headerView: some View {
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
            
            Text("Delivery Address")
                .font(.customFont(.gilroyBold, fontSize: 20))
                .frame(height: 46)
            
            Spacer()
            
            NavigationLink {
                AddDeliveryAddressView()
            } label: {
                Image("add_temp")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(Color.primaryText)
            .padding(.bottom, 8)
        }
        .padding(.top, .topInsets)
        .padding(.horizontal, 20)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.2), radius: 2)
    }
    
    private var addressListView: some View {
        ScrollView {
            LazyVStack(spacing: 15) {
                ForEach(addressVM.listArr, id: \.id) { aObj in
                    addressRowView(for: aObj)
                }
            }
            .padding(20)
            .padding(.top, .topInsets + 46)
            .padding(.bottom, .bottomInsets + 60)
        }
    }
    
    private func addressRowView(for aObj: AddressModel) -> some View {
        HStack(spacing: 15) {
            VStack {
                HStack {
                    Text(aObj.name)
                        .font(.customFont(.gilroyBold, fontSize: 14))
                        .foregroundStyle(Color.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text(aObj.typeName)
                        .font(.customFont(.gilroyBold, fontSize: 12))
                        .foregroundStyle(Color.primaryText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.secondaryText.opacity(0.3))
                        .cornerRadius(5)
                }
                
                Text("\(aObj.address),\(aObj.city), \(aObj.state), \(aObj.postalCode)")
                    .font(.customFont(.gilroyMedium, fontSize: 14))
                    .foregroundStyle(Color.primaryText)
                    .multilineTextAlignment(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(aObj.phone)
                    .font(.customFont(.gilroyBold, fontSize: 12))
                    .foregroundStyle(Color.secondaryText)
                    .padding(.vertical, 8)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                Spacer()
                
                NavigationLink {
                    AddDeliveryAddressView(isEdit: true, editObj: aObj)
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.primaryApp)
                }
                .padding(.bottom, 8)
                
                Button {
                    addressVM.serviceCallRemove(cObj: aObj)
                } label: {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                Spacer()
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(5)
        .shadow(color: Color.black.opacity(0.15), radius: 2)
        .onTapGesture {
            if isPicker {
                dismiss()
                didSelect?(aObj)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DeliveryAddressView()
    }
}
