//
//  SectionTitleAll.swift
//  OnlineGrocery
//
//  Created by enesozmus on 21.08.2025.
//

import SwiftUI

struct SectionTitleAll: View {
    
    @State var title = "Title"
    @State var titleAll = "View All"
    var didTap: (() -> ())?
    
    var body: some View {
        HStack {
            Text(title)
                .font(.customFont(.gilroySemibold, fontSize: 24))
                .foregroundStyle(Color.primaryText)
            
            Spacer()
            
            Text(titleAll)
                .font(.customFont(.gilroySemibold, fontSize: 16))
                .foregroundStyle(Color.primaryApp)
        }
        .frame(height: 40)
    }
}

#Preview {
    SectionTitleAll()
}
