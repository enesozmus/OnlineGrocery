//
//  CategoryCell.swift
//  OnlineGrocery
//
//  Created by enesozmus on 23.08.2025.
//

import SDWebImageSwiftUI
import SwiftUI

struct CategoryCell: View {
    @State var tObj: TypeModel = TypeModel(dict: [ : ])
    @State var color: Color = Color.yellow
    var didAddCart: ( ()->() )?
    
    var body: some View {
        HStack{
            WebImage(url: URL(string: tObj.image ))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: 70, height: 70)
            
            Text(tObj.name)
                .font(.customFont(.gilroyBold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(15)
        .frame(width: 250, height: 100)
        .background( tObj.color.opacity(0.3) )
        .cornerRadius(16)
    }
}

#Preview {
    CategoryCell(tObj: TypeModel(dict: [
        "type_id": 1,
        "type_name": "Pulses",
        "image": "http://192.168.1.3:3001/img/type/202307261610181018aVOpgmY1W1.png",
        "color": "F8A44C"])
    )
}
