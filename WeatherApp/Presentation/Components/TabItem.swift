//
//  TabItem.swift
//  Waya PayChat 2.0
//
//  Created by Toju on 12/01/2021.
//

import SwiftUI

struct TabItem: View {
    @Binding var selection: Int
    var title: String
    @Binding var image: String
    var tag: Int
    
    
    var body: some View {
        VStack{
            Image(systemName: image).renderingMode(.template)
                .foregroundColor(selection == 1 ? .red : .white)
            Text(title)
        }
    }
}

struct TabItem_Previews: PreviewProvider {
    @State static var selection = 1
    static var previews: some View {
        TabItem(selection: $selection, title: "Home", image: .constant("home"), tag: 1)
    }
}
