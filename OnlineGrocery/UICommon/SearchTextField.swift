//
//  SearchTextField.swift
//  OnlineGrocery
//
//  Created by enesozmus on 21.08.2025.
//

import SwiftUI

struct SearchTextField: View {
    @State var placholder = "Placholder"
    @Binding var txt: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image("search")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
            
            TextField(placholder, text: $txt)
                .font(.customFont(.gilroyRegular, fontSize: 17))
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)
        }
        .frame(height: 30)
        .padding(15)
        .background(Color(hex: "F2F3F2"))
        .cornerRadius(16)
    }
}

#Preview {
    //@Previewable @State var searchText = ""
    //SearchTextField(txt: $searchText)
    struct PreviewWrapper: View {
        @State private var searchText = ""
        
        var body: some View {
            SearchTextField(txt: $searchText)
        }
    }
    
    return PreviewWrapper()
}
