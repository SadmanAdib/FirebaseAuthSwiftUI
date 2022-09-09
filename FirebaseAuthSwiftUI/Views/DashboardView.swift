//
//  DashboardView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject var viewModel = AuthViewModel()
    
    init(){
        viewModel.getData()
    }
    
    var body: some View {
        VStack {
            List(viewModel.items) { todo in
                HStack {
                    Text(todo.name)
                    Spacer()
                    
                    Button{
                        //update todo
                        viewModel.selectedTodo = todo
                        viewModel.showingUpdateView = true
                    }label: {
                        Image(systemName: "pencil")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    Button{
                        //delete todo
                        viewModel.deleteData(todoToDelete: todo)
                    }label: {
                        Image(systemName: "xmark.bin.fill")
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .sheet(isPresented: $viewModel.showingUpdateView, onDismiss: {
                    viewModel.getData()
                }) {
                    UpdateView(todo: viewModel.selectedTodo, showingUpdateView: $viewModel.showingUpdateView)
                }
            }
            .listStyle(.plain)
            
            VStack{
                Group{
                    TextField("name", text: $viewModel.name)
                    TextField("notes", text: $viewModel.notes)
                }
                .textFieldStyle(.roundedBorder)
                .cornerRadius(15)
                
                Button {
                    //call add data
                    viewModel.addData(name: viewModel.name, notes: viewModel.notes)
                    
                    //clear text fields
                    viewModel.name = ""
                    viewModel.notes = ""
                } label: {
                    Text("Add Todo Item")
                }
                .buttonStyle(.bordered)
                .tint(.blue)
                .controlSize(.large)
            }
            .padding()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
