//
//  TabButton.swift
//  OnlineGrocery
//
//  Created by enesozmus on 21.08.2025.
//

import SwiftUI

struct TabButton: View {
    
    @State var title = "Title"
    @State var icon = "store_tab"
    var isSelect = false
    var didSelect: (() -> ())
    
    var body: some View {
        Button {
            debugPrint("Tab Button Tap")
            didSelect()
        } label: {
            VStack {
                Image(icon)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                
                Text(title)
                    .font(.customFont(.gilroySemibold, fontSize: 14))
            }
        }
        .foregroundStyle(isSelect ? Color.primaryApp : Color.primaryText)
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}

#Preview {
    TabButton {
        print("Test")
    }
}
