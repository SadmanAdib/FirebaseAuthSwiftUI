//
//  ContentView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    
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
                        
                    } label: {
                        Text(isLoginMode ? "Log In" : "Create Account")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .controlSize(.large)
                    .padding(.bottom, 50)
                }
                .navigationTitle(isLoginMode ? "Log In" : "Create Account")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
