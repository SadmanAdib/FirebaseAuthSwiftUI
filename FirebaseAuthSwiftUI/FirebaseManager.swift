//
//  FirebaseManager.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import Firebase

class FirebaseManager: NSObject {
    
    let auth: Auth
    
    static let shared = FirebaseManager()
    
    override init () {
        FirebaseApp.configure()
        auth = Auth.auth()
        super.init()
    }
}
