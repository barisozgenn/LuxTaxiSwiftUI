//
//  TripRequestView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 28.09.2022.
//

import SwiftUI

struct TripRequestView: View {
    
    @State private var paddinBottom: CGFloat = -529
    @State private var selectedVehicleType : VehicleType = .sport
    @EnvironmentObject var locationViewModel : LocationSearchListViewModel
    
    var body: some View {
        ZStack {
            VStack {
                capsule
                
                // trip info view
                tripInfo
                
                divider
                
                // ride type selection view
                rideTypes
                
                divider
                
                // payment option view
                paymentType
                
                // button
                paymentButton
            }
            .padding(.bottom, paddinBottom)
            .background(Color(.systemGroupedBackground).opacity(0.92))
            .cornerRadius(29)
            .shadow(
                color: .black.opacity(0.58),
                radius: 14,x: 0, y: -7
            )
            .onAppear(perform: {
                withAnimation(.default) {
                    self.paddinBottom = 0
                }
            })
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
                    ForEach(VehicleType.allCases){vechicle in
                        VStack(alignment: .leading){
                            Image(vechicle.imageName)
                                .resizable()
                                .scaledToFit()
                                .padding(.top, 10)
                            VStack(alignment: .leading){
                                Text(vechicle.title)
                                    .foregroundColor(vechicle == selectedVehicleType ? Color(.systemGray5) : Color.theme.goldBackgroundColor)
                                    .fontWeight(.bold)
                                    .font(.headline)
                                Text(/*"$29.07"*/locationViewModel.calculateTripPrice(forType: vechicle).toUSDCurrencyFormatted())
                                    .foregroundColor(vechicle == selectedVehicleType ? Color(.black): Color.theme.primaryTextColor)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.bottom, 8)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                           
                        }
                        .frame(width: 114 ,height: 150)
                        .background(vechicle == selectedVehicleType ? Color.theme.goldBackgroundColor : Color.theme.carItemBackgroundColor)
                        .scaleEffect(vechicle == selectedVehicleType ? 1.17 : 1.0)
                        .cornerRadius(14)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedVehicleType = vechicle
                            }
                        }
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
                    .foregroundColor(Color.theme.goldBackgroundColor)
                
                
                Text("**** 1234".uppercased())
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
        .frame(height: 50, alignment: .leading)
        .background(Color.theme.carItemBackgroundColor)
        .cornerRadius(14)
        .padding(.horizontal)
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
        .padding(.horizontal)
        .padding(.bottom, 26)
        .padding(.top, 20)
    }
    
    private var divider : some View {
        Divider()
            .overlay(Color(.systemGray2))
            .padding(.vertical, 4)
        
    }
}

struct TripRequestView_Previews: PreviewProvider {
    static var previews: some View {
        TripRequestView()
    }
}
