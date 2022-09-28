//
//  LocationSearchListView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 28.09.2022.
//

import SwiftUI

struct LocationSearchListView: View {
    
    @State private var firstLocationText = ""
    @State private var endLocationText = ""
    
    @State private var paddingTop: CGFloat = 429
    @State private var backgroundOpacity: CGFloat = 0

    @StateObject var viewModel = LocationSearchListViewModel()
    
    var body: some View {
        VStack {
            // header view
            headerView
            
            Divider()
                .padding(.vertical)
            
            // list view
            listView
        }
        .background(Color.theme.appBackgroundColor.opacity(backgroundOpacity))
    }
}

extension LocationSearchListView {
    
    private var headerView: some View {
        HStack{
            // Pointers
            VStack{
                Circle()
                    .fill(Color(.systemGray3))
                    .frame(width: 6, height: 6)
                
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: 2, height: 33)
                
                Rectangle()
                    .fill(Color.theme.goldBackgroundColor)
                    .frame(width: 7, height: 7)
            }
            
            // search boxes
            VStack{
                VStack{
                    TextField("Current Location", text: $firstLocationText)
                        .frame(height: 50)
                        
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.theme.carItemBackgroundColor)
                        .shadow(
                            color: .black.opacity(0.29),
                            radius: 4,x: 0, y: 4
                        )
                )
                   
                
                VStack {
                    TextField("Destination Location", text: $viewModel.queryFragment)
                        .frame(height: 50)
                    .foregroundColor(Color.theme.primaryTextColor)
                }
                .padding(.horizontal)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.theme.carItemBackgroundColor)
                        .shadow(
                            color: .black.opacity(0.29),
                            radius: 4,x: 0, y: 4
                        )
                )
            }
        }
        .padding(.horizontal)
        .padding(.top, paddingTop)
        .onAppear(perform: {
            withAnimation(.default) {
                self.paddingTop = 114
                self.backgroundOpacity = 0.92
            }
        })
    }
    
    private var listView: some View {
        ScrollView{
            VStack(alignment: .leading,spacing: 14){
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchCell(locationTitle: result.title, locationDescription: result.subtitle)
                    
                }
            }
        }
        .padding(.bottom, 1)
    }
}
struct LocationSearchListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchListView()
    }
}
