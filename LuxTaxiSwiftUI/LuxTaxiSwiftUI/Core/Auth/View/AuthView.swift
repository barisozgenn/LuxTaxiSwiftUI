//
//  AuthView.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 15.11.2022.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var vm : AuthViewModel
    @StateObject var launchScreenManager = LaunchScreenViewModel()
    @StateObject var locationSearchListViewModel = LocationSearchListViewModel()
    
    @State var countrySelectionViewVisiblity : Bool = false
    
    private let gridItem = GridItem(.flexible(), spacing: 14)

    @State private var animTrans: Bool = false
    @State private var isUserProfileSaved: Bool = false
    
    var body: some View {
        
        ZStack{
            backgroundGradient
            // Login Views
            VStack{
                headerView
                ZStack{
                    phoneNumberView
                    otpView
                }
                
                keyboardView
            }
            .cornerRadius(animTrans ? 29 : 0)
            .clipped()
            .scaleEffect(animTrans ? 0.29 : 1)
            .rotation3DEffect(.degrees(animTrans ? -90 : 0), axis:(x: 0, y: 1, z: 0))
            .offset(x: animTrans ? -230 : 0)
            .onReceive(vm.$userSession) { user in
                if user != nil {
                    withAnimation(.easeInOut(duration: 1.4)){
                        animTrans.toggle()
                    }
                }
            }
            
            if vm.userSession != nil {
                HomeView()
                    .cornerRadius(!animTrans ? 29 : 0)
                    .clipped()
                    .scaleEffect(!animTrans ? 0.29 : 1)
                    .rotation3DEffect(.degrees(!animTrans ? 90 : 0), axis:(x: 0, y: 1, z: 0))
                    .offset(x: !animTrans ? 230 : 0)
                    .environmentObject(locationSearchListViewModel)
                    .environmentObject(launchScreenManager)
            }
            
        }
        .background(backgroundImage)
        .edgesIgnoringSafeArea(.bottom)
           
      
    }
}

extension AuthView {
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
    
    private var headerView: some View {
        ZStack(alignment: .top){
            
            VStack{
                Text((vm.loginStep == .phone ? "Continue with your phone" : "Verify your phone to login").capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Image(vm.loginStep == .phone ? "img-verify-phone" : "img-verify-otp")
                Spacer()
                HStack(spacing:0){
                    Text(vm.loginStep == .phone ? "You can login or register with the SMS verification code." : "+\(vm.phoneCountryCodeText) \(vm.phoneNumberText)")
                        .lineLimit(2)
                        .font(vm.loginStep == .phone ?  .title3 : .title2)
                        .fontWeight(.semibold)
                        .padding()
                    if vm.loginStep == .otp {
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .onTapGesture {
                                withAnimation(.spring()){
                                    vm.loginStep = .phone
                                }
                            }
                    }
                }
               
            }
            .padding(.vertical)
            .padding(.bottom, 114)
        }
        .foregroundColor(.white)
        .shadow(color: .black, radius: 1, x:0, y: 1)
        .padding(.bottom, -107)
    }
    private var phoneNumberView: some View {
        ZStack{
            GeometryReader { geo in
                
                Wave(waveHeight: 14, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.7))
                    .foregroundColor(Color.theme.carItemBackgroundColor)
            }
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text(vm.warningPhoneNumberText.isEmpty ? "Type your phone" : vm.warningPhoneNumberText)
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .foregroundColor(vm.warningPhoneNumberText.isEmpty ? .gray : .orange)
                    HStack{
                        HStack{
                            Text(vm.selectedCountry.emoji)
                            Text("+\(vm.selectedCountry.phone)")
                        }
                        .onTapGesture {
                            countrySelectionViewVisiblity.toggle()
                        }
                        .sheet(isPresented: $countrySelectionViewVisiblity){
                            CountrySelectionView(selectedCountry: $vm.selectedCountry)
                                .accessibilityIdentifier("countrySelectionView")
                                .presentationDetents([.height(292), .fraction(0.52), .fraction(0.7)])
                                .presentationDragIndicator(.visible)
                        }
                        
                        Text(vm.phoneNumberText)
                            .lineLimit(1)
                            .frame(maxWidth: 150, alignment: .leading)
                    }
                    Divider()
                        .background(.primary)
                        .padding(.top, 0)
                        .padding(.trailing, 7)
                    
                }
                .foregroundColor(Color.theme.primaryTextColor)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()){
                        vm.sendSMSButton()
                    }
                }) {
                    Text("Continue")
                        .font(.headline)
                }
                .frame(width: 80)
                .foregroundColor(.white)
                .padding()
                .background(Color.theme.goldBackgroundColor)
                .cornerRadius(4)
                
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .padding(.top, 14)
        }
        .frame(height: 100)
        .offset(x: vm.loginStep == .phone ? 0 : -430)
    }
    private var otpView: some View {
        ZStack{
            GeometryReader { geo in
                Wave(waveHeight: 14, phase: Angle(degrees: Double(geo.frame(in: .global).minY) * 0.3))
                    .foregroundColor(Color.theme.carItemBackgroundColor)
            }
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text(vm.warningOtpText.isEmpty ? "Type sms confirmation code" : vm.warningOtpText)
                        .font(.subheadline)
                        .padding(.vertical,4)
                        .foregroundColor(vm.warningOtpText.isEmpty ? .gray : .orange)
                    HStack{
                        Image(systemName: "lock.shield")
                        Text("CODE")
                            .opacity(0.29)
                        Text(vm.otpText)
                            .lineLimit(1)
                            .frame(maxWidth: 150, alignment: .leading)
                    }
                    Divider()
                        .background(.primary)
                        .padding(.top, 0)
                        .padding(.trailing, 7)
                    
                }
                .foregroundColor(Color.theme.primaryTextColor)
                
                Spacer()
                
                Button(action: {
                    vm.sendOTPButton()
                }) {
                    Text("Verify")
                        .font(.headline)
                }
                .frame(width: 80)
                .foregroundColor(.white)
                .padding()
                .background(Color.theme.goldBackgroundColor)
                .cornerRadius(4)
                
            }
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .padding(.top, 14)
        }
        .frame(height: 100)
        .offset(x: vm.loginStep == .otp ? 0 : 430)
    }
    
    private var keyboardView: some View {
        LazyVGrid(columns:
                    Array(repeating: gridItem, count: 3), spacing: 14) {
            ForEach(vm.padNumbers, id: \.self) { keyTag in
                
                Button(action: {
                    withAnimation(.spring()){
                        switch vm.loginStep {
                        case .phone:
                            vm.setPhoneNumberText(keyTag: keyTag)
                        case .otp:
                            vm.setOTPText(keyTag: keyTag)
                        }
                    }
                }) {
                    if keyTag != vm.padNumbers.last {
                        Text(keyTag)
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                        
                    }
                    else {
                        Image(systemName: keyTag)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                    }
                }
                .fontWeight(.bold)
                .background(Color.theme.carItemBackgroundColor.opacity(keyTag.isEmpty ? 0.29 : 1))
                .cornerRadius(7)
            }
        }
                    .foregroundColor(Color.theme.primaryTextColor)
                    .padding(14)
                    .padding(.bottom)
                    .background(Color.theme.appBackgroundColor)
    }
    
    struct Wave: Shape {
        
        var waveHeight: CGFloat
        var phase: Angle
        
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: rect.maxY)) // Bottom Left
            
            for x in stride(from: 0, through: rect.width, by: 1) {
                let relativeX: CGFloat = x / 50 //wavelength
                let sine = CGFloat(sin(relativeX + CGFloat(phase.radians)))
                let y = waveHeight * sine //+ rect.midY
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // Top Right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom Right
            
            return path
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
            .environmentObject(AuthViewModel())
    }
}
