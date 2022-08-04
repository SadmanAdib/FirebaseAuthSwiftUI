//
//  DashboardView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

struct DashboardView: View {
    
    @ObservedObject private var viewModel = AuthViewModel()
    
    init(){
        viewModel.getData()
    }
    
    var body: some View {
        List(viewModel.items) { item in
            Text(item.name)
        }
        .listStyle(.plain)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
