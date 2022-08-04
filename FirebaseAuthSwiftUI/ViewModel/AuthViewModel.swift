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
    @Published var name = ""
    @Published var notes = ""
    @Published var updatedName = ""
    @Published var updatedNotes = ""
    
    @Published var showingUpdateView = false
    
    func updateData(todoToUpdate: Todo) {
        //get a reference to database
        let db = FirebaseManager.shared.firestore
        
        //set the data to update
        db.collection("todos").document(todoToUpdate.id).setData(["name" : updatedName, "notes" : updatedNotes], merge: true) { error in
            //check for errors
            if error == nil {
                //no error
                self.getData()
            }
            else{
                //handle error
            }
        }
    }
    
    func deleteData(todoToDelete: Todo) {
        //get a reference to database
        let db = FirebaseManager.shared.firestore
        
        //specify document to delete
        db.collection("todos").document(todoToDelete.id).delete { error in
            //check for errors
            if error == nil {
                //no error
                
                //update ui from main thread
                DispatchQueue.main.async {
                    self.items.removeAll { todo in
                        
                        //check for todo to remove
                        return todo.id == todoToDelete.id
                    }
                }
                
                
            }
            else{
                //handle error
            }
        }
    }
    
    func addData(name: String, notes: String){
        //get reference to the database
        let db = FirebaseManager.shared.firestore
        
        //Add a document to collection
        db.collection("todos").addDocument(data: ["name": name, "notes": notes]) { error in
            //check for errors
            if error == nil {
                //no error
                
                //call get data to retrieve the latest data
                self.getData()
            }
            else{
                //handle error
            }
        }
    }
    
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
