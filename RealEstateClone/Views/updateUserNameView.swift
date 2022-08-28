//
//  UpdateUserNameView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 16/01/1444 AH.
//

import SwiftUI

struct updateUserNameView: View {
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @Binding var username : String
    @Environment(\.presentationMode) private var presentationMode
    @State var isloading : Bool = false

    var body: some View {
        VStack{
            Spacer()
            TextField("new user name", text: $username  )
                .modifier(textFieldModifire())
                .padding()
            
            Button {
                isloading.toggle()
                firebaseUserManger.updateUserName(newUserName: username) { isScesse in
                   if isScesse {
                       isloading.toggle()
                       presentationMode.wrappedValue.dismiss()
                   }else{
                       isloading.toggle()

                   }
                    
                    
                }

            } label: {
                Text("update user name".capitalized)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        Color.blue
                            .cornerRadius(15)
                    )
            }
            
            Spacer()


        }.overlay{
            if isloading{
                
                customProgressView()
                
            }
        }
        
        
    }
}

struct UpdateUserNameView_Previews: PreviewProvider {
    static var previews: some View {
        updateUserNameView(username: .constant("test"))
            .environmentObject(FirebaseUserManger())

    }
}
