//
//  AuthViewModel.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI
import FirebaseFirestore


final class AuthViewModel: ObservableObject {
    @Published var isLoginMode = false
    @Published var email = ""
    @Published var password = ""
    @Published var statusMessage = ""
    @Published var showingDashboard = false
    @Published var showingAlert = false
    
    @Published var items: [Todo] = []
    
    
    func getData(){
        //get reference to the database
        let db = FirebaseManager.shared.firestore
        
        db.collection("todos").getDocuments { snapshot, error in
            
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //Update list property (items) in the main thread
                    DispatchQueue.main.async { [self] in
                        
                        //get all documents and create todos in
                        items = snapshot.documents.map{ d in
                            
                            //create a todo item for each document returned
                            return Todo(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        notes: d["notes"] as? String ?? "")
                            
                        }
                    }
                }
            }
            else {
                //handle errors
            }
        }
    }
    
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
