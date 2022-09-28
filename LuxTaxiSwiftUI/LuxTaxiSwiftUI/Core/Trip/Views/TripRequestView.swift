//
//  TripRequestView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 28.09.2022.
//

import SwiftUI

struct TripRequestView: View {
    var body: some View {
        
        ZStack {
            VStack {
                capsule
                
                // trip info view
                tripInfo
                
                Divider()
                    .padding(.vertical)
                
                // ride type selection view
                rideTypes
                
                // payment option view
                paymentType
                
                // button
                paymentButton
            }
            .background(Color.theme.appBackgroundColor)
            .cornerRadius(29)
            .shadow(
                color: .black.opacity(0.58),
                radius: 14,x: 0, y: -7
            )
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
    }
}

extension TripRequestView {
    private var capsule : some View {
        Capsule()
            .foregroundColor(Color(.systemGray4))
            .frame(width: 58, height: 7)
            .padding(.top, 10)
            .padding(.bottom, 14)
    }
    
    private var tripInfo : some View {
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
            .padding(.horizontal)
            
            // locations
            VStack(spacing: 5) {
                Text("Current Location")
                    .frame(height: 45)
                    .foregroundColor(Color(.gray))
                    .fontWeight(.semibold)
                
                Text("Destination Point")
                    .foregroundColor(Color.theme.goldBackgroundColor)
                    .fontWeight(.bold)
                    .frame(height: 45)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            // time info
            VStack(spacing: 5) {
                Text("20:29")
                    .frame(height: 45)
                    .foregroundColor(Color(.gray))
                    .fontWeight(.semibold)
                
                Text("20:58")
                    .foregroundColor(Color.theme.goldBackgroundColor)
                    .fontWeight(.bold)
                    .frame(height: 45)
            }
            .padding(.trailing)
            .frame(alignment: .trailing)
        }
    }
    
    private var rideTypes : some View {
        VStack(spacing: 10){
            Text("Available Vehicles".uppercased())
                .foregroundColor(Color(.gray))
                .fontWeight(.semibold)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)
            
            ScrollView(.horizontal){
                HStack(spacing: 14){
                    ForEach(0..<3, id: \.self){_ in
                        VStack(alignment: .leading){
                            Image("app-car-sedan")
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 10)
                            
                            Text("Sport".uppercased())
                                .foregroundColor(Color.theme.goldBackgroundColor)
                                .fontWeight(.semibold)
                                .font(.headline)
                                .padding(.top)
                                .padding(.horizontal)
                            Text("39.99$".uppercased())
                                .foregroundColor(Color.theme.primaryTextColor)
                                .fontWeight(.semibold)
                                .font(.headline)
                                .padding(.horizontal)
                                .padding(.bottom)
                        }
                        .frame(width: 114 ,height: 150)
                        .background(Color.theme.carItemBackgroundColor)
                        .cornerRadius(14)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var paymentType : some View {
        VStack(spacing: 10){
            HStack(spacing: 14){
                Image(systemName: "creditcard.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 24)
                    .padding()
                    .foregroundColor(.gray)
                
                
                Text("****1234".uppercased())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.primaryTextColor)
                    .fontWeight(.bold)
                    .font(.headline)
                
                Image(systemName: "chevron.right")
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.gray)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.theme.carItemBackgroundColor)
        .cornerRadius(14)
        .padding()
    }
    
    private var paymentButton : some View {
        VStack(spacing: 10){
            Button {
                
            } label : {
                Text("CONFIRM RIDE")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .fontWeight(.bold)
                
            }
            .background(Color(.systemBlue))
            .foregroundColor(Color(.white))
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.carItemBackgroundColor)
        .cornerRadius(14)
        .padding()
        .padding(.bottom, 30)
    }
}

struct TripRequestView_Previews: PreviewProvider {
    static var previews: some View {
        TripRequestView()
    }
}
