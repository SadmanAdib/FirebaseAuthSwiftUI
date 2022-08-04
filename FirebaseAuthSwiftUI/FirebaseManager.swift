//
//  FirebaseManager.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import Firebase
import FirebaseFirestore

class FirebaseManager: NSObject {
    
    let auth: Auth
    let firestore: Firestore
   
    static let shared = FirebaseManager()
    
    override init () {
        FirebaseApp.configure()
        auth = Auth.auth()
        firestore = Firestore.firestore()
        super.init()
    }
}
