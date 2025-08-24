//
//  ProductDetailView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 23.08.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct ProductDetailView: View {
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @StateObject var detailVM: ProductDetailViewModel = ProductDetailViewModel(prodObj: ProductModel(dict: [:]))
    
    private var totalPrice: Double {
        (detailVM.pObj.offerPrice ?? detailVM.pObj.price) * Double(detailVM.qty)
    }
        
    //MARK: - Body
    var body: some View {
        ZStack {
            ScrollView {
                productImageView
                    .frame(width: .screenWidth, height: .screenWidth * 0.8)
                
                VStack {
                    HStack {
                        Text(detailVM.pObj.name)
                            .font(.customFont(.gilroyBold, fontSize: 24))
                            .foregroundStyle(Color.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            detailVM.serviceCallAddRemoveFav()
                        } label: {
                            Image(detailVM.isFav ? "favorite" : "fav")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundStyle(Color.secondaryText)
                    }
                    
                    Text("\(detailVM.pObj.unitValue)\(detailVM.pObj.unitName), Price")
                        .font(.customFont(.gilroySemibold, fontSize: 16))
                        .foregroundStyle(Color.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        Button {
                            detailVM.addSubQTY(isAdd: false)
                        } label: {
                            Image( "subtack"  )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        
                        Text("\(detailVM.qty)")
                            .font(.customFont(.gilroyBold, fontSize: 24))
                            .foregroundStyle(Color.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                        
                        Button {
                            detailVM.addSubQTY(isAdd: true)
                        } label: {
                            Image("add_green")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .padding(10)
                        }
                        
                        Spacer()
                        
                        Text("$\(totalPrice, specifier: "%.2f")")
                            .font(.customFont(.gilroyBold, fontSize: 28))
                            .foregroundStyle(Color.primaryText)
                    }
                    .padding(.vertical, 8)
                    
                    Divider()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                productDetailSection
                
                nutritionsSection
                
                HStack {
                    Text("Review")
                        .font(.customFont(.gilroySemibold, fontSize: 16))
                        .foregroundStyle(Color.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack(spacing: 2) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: "star.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.orange)
                                .frame(width: 15, height: 15)
                        }
                    }
                    
                    Button {
                        //
                    } label: {
                        Image("next")
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                            .padding(15)
                    }
                    .foregroundStyle(Color.primaryText)
                }
                .padding(.horizontal, 20)
                
                //                RoundButton(title: "Add To Basket") {
                //                    CartViewModel.serviceCallAddToCart(prodId: detailVM.pObj.prodId, qty: detailVM.qty) { isDone, msg  in
                //
                //                        detailVM.qty = 1
                //
                //                        self.detailVM.errorMessage = msg
                //                        self.detailVM.showError = true
                //                    }
                //                }
                //                .padding( 20)
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
                    
                    Button {
                        //
                    } label: {
                        Image("share")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                    }
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
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .ignoresSafeArea()
    }
    
    //MARK: - Subviews
    private var productImageView: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(Color(hex: "F2F2F2"))
                .frame(width: .screenWidth, height: .screenWidth * 0.8)
                .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
            
            WebImage(url: URL(string: detailVM.pObj.image))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
        }
    }
    
    var productDetailSection: some View {
        VStack {
            HStack {
                Text("Product Detail")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Button {
                    withAnimation {
                        detailVM.showDetail()
                    }
                } label: {
                    Image(detailVM.isShowDetail ? "detail_open" : "next" )
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(15)
                }
                .foregroundStyle(Color.primaryText)
            }
            
            if(detailVM.isShowDetail) {
                Text(detailVM.pObj.detail)
                    .font(.customFont(.gilroyMedium, fontSize: 13))
                    .foregroundStyle(Color.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom , 8)
            }
            
            Divider()
        }
        .padding(.horizontal, 20)
    }

    var nutritionsSection: some View {
        VStack {
            HStack {
                Text("Nutritions")
                    .font(.customFont(.gilroySemibold, fontSize: 16))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text(detailVM.pObj.nutritionWeight)
                    .font(.customFont(.gilroySemibold, fontSize: 10))
                    .foregroundStyle(Color.secondaryText)
                    .padding(8)
                    .background(Color.placeholder.opacity(0.5))
                    .cornerRadius(5)
                
                Button {
                    withAnimation {
                        detailVM.showNutrition()
                    }
                } label: {
                    Image(detailVM.isShowNutrition ? "detail_open" : "next" )
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .padding(15)
                }
                .foregroundStyle(Color.primaryText)
            }
            
            if(detailVM.isShowNutrition) {
                LazyVStack {
                    ForEach(detailVM.nutritionArr, id: \.id) { nObj in
                        HStack {
                            Text(nObj.nutritionName)
                                .font(.customFont(.gilroySemibold, fontSize: 15))
                                .foregroundStyle(Color.secondaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            Text(nObj.nutritionValue)
                                .font(.customFont(.gilroySemibold, fontSize: 15))
                                .foregroundStyle(Color.primaryText)
                        }
                        
                        Divider()
                    }
                    .padding(.vertical, 0)
                }
                .padding(.horizontal, 10)
            }
            
            Divider()
        }
        .padding(.horizontal, 20)
    }
}



#Preview {
    ProductDetailView(detailVM: ProductDetailViewModel(prodObj: ProductModel(dict: [
        "offer_price": 2.49,
        "start_date": "2023-07-30T18:30:00.000Z",
        "end_date": "2023-08-29T18:30:00.000Z",
        "prod_id": 5,
        "cat_id": 1,
        "brand_id": 1,
        "type_id": 1,
        "name": "Organic Banana",
        "detail": "banana, fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world. The banana is grown in the tropics, and, though it is most widely consumed in those regions, it is valued worldwide for its flavour, nutritional value, and availability throughout the year",
        "unit_name": "pcs",
        "unit_value": "7",
        "nutrition_weight": "200g",
        "price": 2.99,
        "image": "http://192.168.1.3:3001/img/product/202307310947354735xuruflIucc.png",
        "cat_name": "Frash Fruits & Vegetable",
        "type_name": "Pulses",
        "is_fav": 1]))
    )
}
