//
//  FavouriteRow.swift
//  OnlineGrocery
//
//  Created by enesozmus on 24.08.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouriteRow: View {
    @State var fObj: ProductModel = ProductModel(dict: [:])
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                WebImage(url: URL(string: fObj.image ))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4) {
                    Text(fObj.name)
                        .font(.customFont(.gilroyBold, fontSize: 16))
                        .foregroundStyle(Color.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(fObj.unitValue)\(fObj.unitName), price")
                        .font(.customFont(.gilroyMedium, fontSize: 14))
                        .foregroundStyle(Color.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                }
                
                Text("$\(fObj.offerPrice ?? fObj.price, specifier: "%.2f" )")
                    .font(.customFont(.gilroySemibold, fontSize: 18))
                    .foregroundStyle(Color.primaryText)
                
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            
            Divider()
        }
    }
}

#Preview {
    FavouriteRow()
}
