//
//  ContentView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        NavigationView{
            ZStack {
                Color((.init(white: 0, alpha: 0.05))).ignoresSafeArea()
                
                VStack(spacing: 20) {
                    PageSelector(selectedPage: $viewModel.isLoginMode)
                    
                    if !viewModel.isLoginMode{
                        ImageSelectorView()
                        
                        Text("Select a picture")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    Form{
                        TextField("Email", text: $viewModel.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                        SecureField("Password", text: $viewModel.password)
                    }
                    .background(.white)
                    .cornerRadius(15)
                    .disableAutocorrection(true)
                    .padding(.vertical, -20)
                    
                    Spacer()
                    
                    Button{
                        viewModel.handleAction()
                    } label: {
                        Text(viewModel.isLoginMode ? "Log In" : "Create Account")
                    }
                    .buttonStyle(.bordered)
                    .tint(.blue)
                    .controlSize(.large)
                    .padding(.bottom, 50)
                    .disabled(viewModel.email.isEmpty || viewModel.password.count<6)
                }
                .navigationTitle(viewModel.isLoginMode ? "Log In" : "Create Account")
            }
        }
        .sheet(isPresented: $viewModel.showingDashboard){
            DashboardView()
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(title: Text(viewModel.statusMessage), dismissButton: .default(Text("Ok")))
        }
        .navigationViewStyle(StackNavigationViewStyle()) // gets rid of log errors.
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

struct PageSelector: View {
    
    var selectedPage: Binding<Bool>
    
    var body: some View {
        Picker("This is picker", selection: selectedPage) {
            Text("Login")
                .tag(true)
            Text("Create Account")
                .tag(false)
        }
        .pickerStyle(.segmented)
        .padding()
    }
}


