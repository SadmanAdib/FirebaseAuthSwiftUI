//
//  UpdateView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 4/8/22.
//

import SwiftUI

struct UpdateView: View {
    
    @ObservedObject private var viewModel = AuthViewModel()
    var todo: Todo
    @Binding var showingUpdateView: Bool
    
    var body: some View {
        VStack{
            Group{
                TextField("name to update", text: $viewModel.updatedName)
                TextField("notes to update", text: $viewModel.updatedNotes)
            }
            .textFieldStyle(.roundedBorder)
            .cornerRadius(15)
            
            Button {
                showingUpdateView = false
                viewModel.updateData(todoToUpdate: todo)
            } label: {
                Text("Update")
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            .controlSize(.large)
        }
    }
}

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateView(todo: Todo(id: "", name: "", notes: ""), showingUpdateView: .constant(true))
    }
}
