//
//  AuthViewModel.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

final class AuthViewModel: ObservableObject {
   @Published var isLoginMode = false
   @Published var email = ""
   @Published var password = ""
   @Published var statusMessage = ""
   @Published var showingDashboard = false
   @Published var showingAlert = false
    
    func handleAction(){
        if isLoginMode{
            loginUser()
        }
        else{
            createAccount()
        }
    }
    
    func createAccount(){
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { [self] result, err in
            if let err = err {
                statusMessage = "Failed to create user: \(err.localizedDescription)"
                showingAlert = true
                return
            }
            
            statusMessage = "Successfully created user: \(result?.user.uid ?? "")"
            showingAlert = true
        }
    }
    
    func loginUser(){
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { [self] result, err in
            if let err = err {
                statusMessage = "Failed to sign in: \(err.localizedDescription)"
                showingAlert = true
                return
            }
            showingDashboard = true
           // statusMessage = "Successfully logged in: \(result?.user.uid ?? "")"
        }
    }
    
    
    
}
