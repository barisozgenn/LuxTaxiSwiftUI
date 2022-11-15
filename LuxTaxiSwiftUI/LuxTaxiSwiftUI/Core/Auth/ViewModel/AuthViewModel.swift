//
//  AuthViewModel.swift
//  LuxTaxiSwiftUI
//
//  Created by Baris OZGEN on 15.11.2022.
//

import Firebase

class AuthViewModel: ObservableObject {
    private let authManager = AuthManager.shared

    @Published var userSession: Firebase.User?

    @Published var loginStep : ELoginStep = .phone
    @Published var padNumbers = ["1","2","3","4","5","6","7","8","9","","0","delete.left"]
    @Published var phoneCountryCodeText: String = "49"
    @Published var phoneNumberText: String = ""
    @Published var otpText: String = ""
    
    @Published var warningPhoneNumberText: String = ""
    @Published var warningOtpText: String = ""
    
    @Published var selectedCountry = CountriesQuery.Data.Country(code: "DE", name: "Germany", emoji: "🇩🇪", phone: "49")
    
    private var recievedOTPText: String = ""
    
    init(){
        self.userSession = authManager.userSession
    }
    
    //MARK: Phone Number Section
    func setPhoneNumberText(keyTag: String){
        
        //check if empty button pressed
        guard !keyTag.isEmpty else {return}
        
        // number button pressed
        if let numberButton = Int(keyTag),
           phoneNumberText.count < 16 {
            phoneNumberText += "\(numberButton)"
            return
        }
        
        // delete button pressed
        if keyTag == padNumbers.last,
           !phoneNumberText.isEmpty {
            phoneNumberText.removeLast()
        }
    }
    
    func sendSMSButton(){
        if phoneNumberText.count < 10 ||
           phoneNumberText.count > 15 {
            warningPhoneNumberText = "⚠ Invalid phone number"
            return
        }
        warningPhoneNumberText = ""
        loginStep = .otp
        
        // For testing we define it true, when the real message is required we need to make it false
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let phoneNumber = "+\(selectedCountry.phone)\(phoneNumberText)"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil){ [weak self] (verificationCode, error) in
            if let error = error {
                self?.warningPhoneNumberText = error.localizedDescription
                return
            }
            
            guard let recievedOTPText = verificationCode else {return}
            self?.recievedOTPText = recievedOTPText
        }
    }
    
    // MARK: OTP Section
    func setOTPText(keyTag: String){
        
        //check if empty button pressed
        guard !keyTag.isEmpty else {return}
        
        // number button pressed
        if let numberButton = Int(keyTag),
           otpText.count < 7 {
            otpText += "\(numberButton)"
            return
        }
        
        // delete button pressed
        if keyTag == padNumbers.last,
           !otpText.isEmpty {
            otpText.removeLast()
        }
    }
    
    func sendOTPButton(){
        if otpText.count != 6 {
            warningOtpText = "⚠ Invalid confirmation code"
            return
        }
        warningOtpText = ""
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: recievedOTPText,
            verificationCode: otpText)
        
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            
            if let error = error {
                self?.warningOtpText = error.localizedDescription
                return
            }
            // here: user logged in
            guard let user = result?.user else {return}
            self?.userSession = user
        }
        
    }
    
    enum ELoginStep : Int {
        case phone
        case otp
    }
}
