//
//  MyOrdersView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 27.08.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyOrdersView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var myVM = MyOrdersViewModel.shared
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(myVM.listArr, id: \.id, content: { myObj in
                        NavigationLink {
                            MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: myObj))
                        } label: {
                            VStack {
                                HStack {
                                    Text("Order No: #")
                                        .font(.customFont(.gilroyBold, fontSize: 16))
                                        .foregroundStyle(Color.primaryText)
                                    
                                    Text("\(myObj.id)")
                                        .font(.customFont(.gilroyBold, fontSize: 14))
                                        .foregroundStyle(Color.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    Text(getOrderStatus(mObj: myObj))
                                        .font(.customFont(.gilroyBold, fontSize: 16))
                                        .foregroundStyle(getOrderStatusColor(mObj: myObj))
                                }
                                
                                Text(myObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                    .font(.customFont(.gilroyBold, fontSize: 12))
                                    .foregroundStyle(Color.secondaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    if let imgageUrl = myObj.images.first {
                                        WebImage(url: URL(string: imgageUrl ))
                                            .resizable()
                                            .indicator(.activity)
                                            .transition(.fade(duration: 0.5))
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                    }
                                    VStack {
                                        HStack {
                                            Text("Items:")
                                                .font(.customFont(.gilroyBold, fontSize: 16))
                                                .foregroundStyle(Color.primaryText)
                                            
                                            Text(myObj.names)
                                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                                .foregroundStyle(Color.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("Delivery Type:")
                                                .font(.customFont(.gilroyBold, fontSize: 16))
                                                .foregroundStyle(Color.primaryText)
                                            
                                            Text(self.getDeliveryType(mObj: myObj))
                                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                                .foregroundStyle(Color.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("Payment Type:")
                                                .font(.customFont(.gilroyBold, fontSize: 16))
                                                .foregroundStyle(Color.primaryText)
                                            
                                            Text(getPaymentType(mObj: myObj))
                                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                                .foregroundStyle(Color.secondaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                        
                                        HStack {
                                            Text("Payment Status:")
                                                .font(.customFont(.gilroyBold, fontSize: 16))
                                                .foregroundStyle(Color.primaryText)
                                            
                                            Text( getPaymentStatus(mObj: myObj))
                                                .font(.customFont(.gilroyMedium, fontSize: 14))
                                                .foregroundStyle(getPaymentStatusColor(mObj: myObj))
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(15)
                        .background(Color.white)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.15), radius: 2)
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
                    
                    Text("My Ordres")
                        .font(.customFont(.gilroyBold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.2),  radius: 2)
                
                Spacer()
            }
        }
        .navigationTitle("")
        .toolbarVisibility(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    //MARK: Functions
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
            case 1:
                return "Placed"
            case 2:
                return "Accepted";
            case 3:
                return "Delivered";
            case 4:
                return "Cancel";
            case 5:
                return "Declined";
            default:
                return "";
        }
    }
    
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
            case 1:
                return "Delivery";
            case 2:
                return "Collection";
            default:
                return "";
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
            case 1:
                return "Cash On Delivery";
            case 2:
                return "Online Card Payment";
            default:
                return "";
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
            case 1:
                return "Processing";
            case 2:
                return "Success";
            case 3:
                return "Fail";
            case 4:
                return "Refunded";
            default:
                return "";
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        if (mObj.paymentType == 1) {
            return Color.orange;
        }
        
        switch mObj.paymentStatus {
            case 1:
                return Color.blue;
            case 2:
                return Color.green;
            case 3:
                return Color.red;
            case 4:
                return Color.green;
            default:
                return Color.white;
        }
    }
    
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
        
        switch mObj.orderStatus {
            case 1:
                return Color.blue;
            case 2:
                return Color.green;
            case 3:
                return Color.green;
            case 4:
                return Color.red;
            case 5:
                return Color.red;
            default:
                return Color.primaryApp;
        }
    }
}

#Preview {
    NavigationStack {
        MyOrdersView()
    }
}
