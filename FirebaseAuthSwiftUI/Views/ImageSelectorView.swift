//
//  ImageSelectorView.swift
//  FirebaseAuthSwiftUI
//
//  Created by Sadman Adib on 3/8/22.
//

import SwiftUI

struct ImageSelectorView: View {
    var body: some View {
        Group{
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
        }
    }
}

struct ImageSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSelectorView()
    }
}
