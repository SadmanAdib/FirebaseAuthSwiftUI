//
//  ContentView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI
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

struct AuthView: View {
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var statusMessage = ""
    @State private var showingDashboard = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color((.init(white: 0, alpha: 0.05))).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Picker("This is picker", selection: $isLoginMode) {
                        Text("Login")
                            .tag(true)
                        Text("Create Account")
                            .tag(false)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    if !isLoginMode{
                        Button{
                            
                        } label: {
                            ZStack{
                                Circle()
                                    .stroke(.blue, lineWidth: 5)
                                    .frame(width: 120, height: 120)
                                
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                            }
                        }
                        .shadow(radius: 5)
                        
                        Text("Select a picture")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                    }
                    
                    Form{
                        TextField("Email", text: $email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $password)
                    }
                    .background(.white)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .padding(.vertical, -20)
                    
                    Spacer()
                    
                    Button{
                        handleAction()
                    } label: {
                        Text(isLoginMode ? "Log In" : "Create Account")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .controlSize(.large)
                    .padding(.bottom, 50)
                    .disabled(email.isEmpty || password.count<6)
                }
                .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            }
        }
        .sheet(isPresented: $showingDashboard){
            DashboardView()
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(statusMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationViewStyle(StackNavigationViewStyle()) // gets rid of log errors.
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
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
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
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, err in
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
