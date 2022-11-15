//
//  LaunchScreenView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 29.09.2022.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @State var appear = false
    
    @State var logoWidth : Double = 292
    
    @State var roadDegree : Double = 22
    @State var roadY : Double = 1000
    @State var roadLineX : Double = -100
    
    @State var carShake : Double = 7
    
    private let timer = Timer.publish(every: 1.29,
                                      on: .main,
                                      in: .common).autoconnect()
    @State var screenOpacity : Double = 1
    
    var body: some View {
        ZStack{
            Color.theme.carItemBackgroundColor
                .ignoresSafeArea()
            
            GeometryReader{ proxy in
                
                // road line
                ZStack{}
                    .frame(width: 92, height: 14)
                    .background(Color.theme.goldBackgroundColor.opacity(0.29))
                    .position(x: roadLineX, y: proxy.size.height / 2 + ( -29 + carShake) )
                    .rotationEffect(Angle(degrees: roadDegree))
                    .onAppear{
                        withAnimation(.spring()){
                            roadLineX = proxy.size.width + 200
                        }
                        withAnimation(.easeOut(duration: 0.92).repeatForever(autoreverses: false)){
                            roadLineX = -200
                        }
                    }
                
                // roadside
                ZStack{}
                    .frame(width: 1000, height: 1000)
                    .background(Color(.systemGray6))
                    .position(x: proxy.size.width / 2, y: roadY + carShake )
                    .rotationEffect(Angle(degrees: roadDegree))
                    .onAppear{
                        withAnimation(.linear(duration: 2.7).repeatForever(autoreverses: true)){
                            roadDegree = 20
                            roadY = 990
                        }
                    }
                
                
                // car
                
                Image("logo-app-launch")
                    .resizable()
                    .scaledToFit()
                    .frame(width: logoWidth)
                    .position(x: proxy.size.width / 2 , y: (proxy.size.height / 2) + carShake)
                
                    .onAppear{
                        withAnimation(.linear(duration: 1.7).repeatForever(autoreverses: true)){
                            carShake = 0
                            
                        }
                    }
                
                
            }
            
            VStack{
                Circle()
                    .trim(from: 0.2, to: 1)
                    .stroke(Color.theme.goldBackgroundColor, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                    .frame(width: 29, height: 29)
                    .rotationEffect(Angle(degrees: appear ? 360 : 0))
                    .onAppear {
                        withAnimation(.linear(duration: 1.7).repeatForever(autoreverses: false)){
                            appear = true
                        }
                    }
                Text("Lux Taxi")
                    .foregroundColor(Color.theme.goldBackgroundColor)
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 29)
            
            
        }
        .onReceive(timer){input in
            withAnimation(.easeInOut){
               // screenOpacity = 0
            }
            
        }
        .opacity(screenOpacity)
        
        
        
    }
}


struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
