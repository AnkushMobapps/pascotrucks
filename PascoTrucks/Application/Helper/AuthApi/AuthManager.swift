//
//  AuthManager.swift
//  THE-GAS-KIOSK
//
//  Created by Hemant Kumar on 19/10/22.
//
//
import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private var varificationId: String?
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool)->Void){
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] varificationId, error in
            guard let varificationId = varificationId, error == nil else {
                completion(false)
                return
            }
            self?.varificationId = varificationId
            completion(true)
        }
    }
    
    public func varifyCode(smsCode: String, completion: @escaping (Bool)->Void){
        guard let varificationId = varificationId else{
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: varificationId, verificationCode: smsCode)
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}


