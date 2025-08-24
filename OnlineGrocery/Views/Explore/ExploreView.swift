//
//  ExploreView.swift
//  OnlineGrocery
//
//  Created by enesozmus on 24.08.2025.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var explorVM = ExploreViewModel.shared
    @State private var txtSearch = ""
    
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    
                    Text("Find Products")
                        .font(.customFont(.gilroyBold, fontSize: 20))
                        .frame(height: 46)
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                
                SearchTextField(placholder: "Search Store", txt: $txtSearch)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 4)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(explorVM.listArr, id: \.id) { cObj in
                            NavigationLink(destination: ExploreItemsView(itemsVM: ExploreItemViewModel(catObj: cObj) ) ) {
                                ExploreCategoryCell(cObj: cObj)
                                    .aspectRatio( 0.95, contentMode: .fill)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ExploreView()
}
