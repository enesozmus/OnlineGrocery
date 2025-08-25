//
//  AccountRow.swift
//  OnlineGrocery
//
//  Created by enesozmus on 25.08.2025.
//

import SwiftUI

struct AccountRow: View {
    @State var title = "Title"
    @State var icon = "a_order"
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20 )
                
                Text(title)
                    .font(.customFont(.gilroySemibold, fontSize: 18))
                    .foregroundStyle(Color.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15 )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            
            Divider()
        }
    }
}

#Preview {
    AccountRow()
}
