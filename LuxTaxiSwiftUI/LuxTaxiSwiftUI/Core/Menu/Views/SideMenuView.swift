//
//  SideMenuView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 30.09.2022.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        ZStack(alignment: .leading){
            
            backgroundGradient
            
            menuList
        }
        .background(backgroundImage)
    }
}

extension SideMenuView {
    private var backgroundImage : some View {
       
            Image("bg-menu")
                .resizable()
                .scaledToFill()
                .blur(radius: 14)
                .ignoresSafeArea()
   
       
            
    }
    private var backgroundGradient : some View {
        LinearGradient(
            colors: [
                Color.theme.goldBackgroundColor,
                Color.theme.carItemBackgroundColor
            ],
            startPoint: .top,
            endPoint: .bottom)
        .blur(radius: 92)
        .opacity(0.58)
        .ignoresSafeArea()
    }
    
    private var menuList : some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Lux Taxi".uppercased())
                .foregroundColor(Color(.white))
                .fontWeight(.semibold)
                .font(.headline)
                .padding(.bottom, 10)
                .shadow(
                    color: .black.opacity(0.58),
                    radius: 2,x: 0, y: 3
                )
            
            ScrollView(.vertical){
                VStack(spacing: 4){
                    ForEach(SideMenu.allCases){menu in
                        HStack(alignment: .top){
                            Image(systemName: menu.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .padding(.trailing, 10)
                                .padding(.top, 7)
                                .shadow(
                                    color: .black.opacity(0.58),
                                    radius: 2,x: 0, y: 3
                                )
                            VStack(alignment: .leading){
                                
                                Text(menu.title)
                                    .fontWeight(.bold)
                                    .font(.headline)
                                    .shadow(
                                        color: .black.opacity(0.92),
                                        radius: 2,x: 1, y: 3
                                    )
                                
                                Divider()
                                    .background(.white)
                                    .padding(.vertical,4)
                                
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 8)
                           
                        }
                        .frame(width: 229)
                        .foregroundColor(.white)
                    }
                }
            }
        }
        .padding(.top, 129)
        .padding(.leading, 14)
    }
}
struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView()
    }
}
