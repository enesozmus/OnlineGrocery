//
//  MyOrdersDetailView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 27.08.2025.
//

import SwiftUI

struct MyOrdersDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var detailVM: MyOrderDetailViewModel = MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [:]) )
    @State var showWriteReview = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("Order ID: # \( detailVM.pObj.id)")
                            .font(.customFont(.gilroyBold, fontSize: 20))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text(getPaymentStatus(mObj: detailVM.pObj))
                            .font(.customFont(.gilroyBold, fontSize: 18))
                            .foregroundStyle(getPaymentStatusColor(mObj: detailVM.pObj))
                    }
                    
                    HStack{
                        Text(detailVM.pObj.createdDate.displayDate(format: "yyyy-MM-dd hh:mm a"))
                            .font(.customFont(.gilroyRegular, fontSize: 12))
                            .foregroundStyle(Color.secondaryText)
                        
                        Spacer()
                        
                        Text(getOrderStatus(mObj: detailVM.pObj))
                            .font(.customFont(.gilroyBold, fontSize: 18))
                            .foregroundStyle(getOrderStatusColor(mObj: detailVM.pObj))
                    }
                    .padding(.bottom, 8)
                    
                    Text("\(detailVM.pObj.address),\(detailVM.pObj.city), \(detailVM.pObj.state), \(detailVM.pObj.postalCode)")
                        .font(.customFont(.gilroyRegular, fontSize: 16))
                        .foregroundStyle(Color.secondaryText)
                        .multilineTextAlignment( .leading)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    HStack {
                        Text("Delivery Type:")
                            .font(.customFont(.gilroyMedium, fontSize: 16))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text(getDeliveryType(mObj: detailVM.pObj))
                            .font(.customFont(.gilroyRegular, fontSize: 16))
                            .foregroundStyle(Color.primaryText)
                    }
                    .padding(.bottom, 4)
                    
                    HStack{
                        Text("Payment Type:")
                            .font(.customFont(.gilroyMedium, fontSize: 16))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text(getPaymentType(mObj: detailVM.pObj))
                            .font(.customFont(.gilroyRegular, fontSize: 16))
                            .foregroundStyle(Color.primaryText)
                    }
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.top, .topInsets + 46)
                
                LazyVStack {
                    ForEach(detailVM.listArr, id: \.id) { pObj in
                        OrderItemRow(pObj: pObj, showReviewBotton: detailVM.pObj.orderStatus == 3 && pObj.rating == 0) {
                            showWriteReview = true
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Amount:")
                            .font(.customFont(.gilroyBold, fontSize: 18))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text("$\(detailVM.pObj.totalPrice, specifier: "%.2f")")
                            .font(.customFont(.gilroyMedium, fontSize: 18))
                            .foregroundStyle(Color.primaryText )
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Delivery Cost:")
                            .font(.customFont(.gilroyBold, fontSize: 18))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text("+ $\(detailVM.pObj.deliverPrice ?? 0.0, specifier: "%.2f")")
                            .font(.customFont(.gilroyMedium, fontSize: 18))
                            .foregroundStyle(Color.primaryText)
                    }
                    .padding(.bottom, 4)
                    
                    HStack {
                        Text("Discount Cost:")
                            .font(.customFont(.gilroyBold, fontSize: 18))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text("- $\(detailVM.pObj.discountPrice ?? 0.0, specifier: "%.2f" )")
                            .font(.customFont(.gilroyMedium, fontSize: 18))
                            .foregroundStyle(.red )
                    }
                    .padding(.bottom, 4)
                    
                    Divider()
                    
                    HStack {
                        Text("Total:")
                            .font(.customFont(.gilroyBold, fontSize: 22))
                            .foregroundStyle(Color.primaryText)
                        
                        Spacer()
                        
                        Text("$\(detailVM.pObj.userPayPrice ?? 0.0, specifier: "%.2f")")
                            .font(.customFont(.gilroyBold, fontSize: 22))
                            .foregroundStyle(Color.primaryText)
                    }
                    .padding(.bottom, 4)
                }
                .padding(15)
                .background(Color.white)
                .cornerRadius(5)
                .shadow(color: Color.black.opacity(0.15), radius: 2)
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
                    
                    Spacer()
                    
                    Text("My Order Detail")
                        .font(.customFont(.gilroySemibold, fontSize: 16))
                        .foregroundStyle(Color.primaryText)
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            
        }
        .alert(isPresented: $detailVM.showError, content: {
            Alert(
                title: Text(Globs.AppName),
                message: Text(detailVM.errorMessage),
                dismissButton: .default(Text("Ok"))
            )
        })
        //        .background(NavigationLink(destination: WriteReviewView(), isActive: $showWriteReview, label: {
        //            EmptyView()
        //        }))
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbarVisibility(.hidden, for: .navigationBar)
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
    MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: MyOrderModel(dict: [
        "order_id": 4,
        "cart_id": "22,23",
        "total_price": 10.450000000000001,
        "user_pay_price": 11.405000000000001,
        "discount_price": 1.0450000000000002,
        "deliver_price": 2,
        "deliver_type": 1,
        "payment_type": 2,
        "payment_status": 2,
        "order_status": 1,
        "status": 1,
        "created_date": "2023-08-10T05:09:14.000Z",
        "names": "Organic Banana,Red Apple",
        "images": "http://localhost:3001/img/product/202307310947354735xuruflIucc.png,http://localhost:3001/img/product/202307310951365136W6nJvPCdzQ.png",
        "user_name": "My Home",
        "phone": "98765432102",
        "address": "246/ A, Dhutpeshwar Bldg, Girgaon Road, Near Gai Wadi, Girgaon",
        "city": "Mumbai",
        "state": "Maharashtra",
        "postal_code": "400004"]))
    )
}
