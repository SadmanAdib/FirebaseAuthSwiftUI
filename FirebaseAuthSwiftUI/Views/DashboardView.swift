//
//  DashboardView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        Text("This is Dashboard")
            .bold()
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
