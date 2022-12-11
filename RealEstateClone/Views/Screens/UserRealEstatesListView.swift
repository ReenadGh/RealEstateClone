//
//  UserRealEstatesListView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 07/02/1444 AH.
//

import SwiftUI

struct UserRealEstatesListView: View {
        @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger

    var body: some View {
        VStack{
            HStack {
                
                Text("My Real Estates")
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                    .padding(.top , 10)

                Spacer()
            }
            
        if (firebaseRealEstateManger.userRealEstates.isEmpty){
            Spacer()
            VStack(spacing : 15){
                Image(systemName : "house.fill")
                    .imageScale(.large)
                Text("You did't add any Real Estates ! " )
                
            }
            .foregroundColor(.gray)

            Spacer()
            
        }else{
                
            VStack {
                ScrollView {
                        ForEach($firebaseRealEstateManger.userRealEstates) { $realEstate in
                            UserRealEstateView(realEstate: $realEstate )
                            .padding()

                        
                        }
                }
                Rectangle()
              .frame( height: 90)
              .frame(maxWidth : .infinity)
              .foregroundColor(.black)
          
                
                
            }

            }
        }
        
        
        }

}

struct UserRealEstatesListView_Previews: PreviewProvider {
    static var previews: some View {
        UserRealEstatesListView()
            .environmentObject(FirebaseRealEstateManger())

    }
}
