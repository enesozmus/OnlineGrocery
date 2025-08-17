//
//  RoundButton.swift
//  OnlineGrocery
//
//  Created by enesozmus on 17.08.2025.
//

import SwiftUI

struct RoundButton: View {
    @State var title = "Tittle"
    var didTap: (()->())?
    
    var body: some View {
        Button {
            didTap?()
        } label: {
            Text(title)
                .font(.customFont(.gilroySemibold, fontSize: 18))
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
        .background(Color.primaryApp)
        .cornerRadius(20)
    }
}

#Preview {
    RoundButton()
}
