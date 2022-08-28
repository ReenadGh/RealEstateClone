//
//  TextFieldModeifier.swift
//  RealEstateClone
//
//  Created by Reenad gh on 16/01/1444 AH.
//

import SwiftUI
struct textFieldModifire : ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                Color(UIColor.systemGray6)
           .cornerRadius(16)
            )
        .padding(.horizontal , 20)
    }
    
}
