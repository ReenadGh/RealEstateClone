//
//  UpdatePhoneNumView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 16/01/1444 AH.
//

import SwiftUI

    import SwiftUI

    struct updatePhoneNumView: View {
        @EnvironmentObject var firebaseUserManger : FirebaseUserManger
        @Binding var phoneNum : String
        @Environment(\.presentationMode) private var presentationMode
        @State var isloading : Bool = false

        var body: some View {
            VStack{
                TextField("new phone number ", text: $phoneNum)
                    .modifier(textFieldModifire())
                    .padding()
                Button {
                    firebaseUserManger.updatePhoneNum(newUserName: phoneNum) { _ in
                        
                    }
                    presentationMode.wrappedValue.dismiss()

                } label: {
                    Text("update phone number".capitalized)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Color.blue
                                .cornerRadius(15)
                        )
                }

            }
            
            
            
        }
    }

    struct UpdatePhoneNumView_Previews: PreviewProvider {
        static var previews: some View {
            updatePhoneNumView(phoneNum: .constant("055555"))
                .environmentObject(FirebaseUserManger())

        }
    }
