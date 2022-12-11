//
//  UserFavRealEstates.swift
//  RealEstateClone
//
//  Created by Reenad gh on 09/02/1444 AH.
//

import SwiftUI

struct UserFavRealEstates: View {
    @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger

    var body: some View {
        VStack {
            HStack {
                
                Text("Favorite Real Estates")
                    .font(.largeTitle).bold()
                    .multilineTextAlignment(.leading)
                    .padding(.leading)
                    .padding(.top , 10)

                Spacer()
            }
            
        if (firebaseRealEstateManger.bookMarkRealEstates.isEmpty){
            Spacer()

            VStack(spacing : 15){
                Image(systemName : "house.fill")
                    .imageScale(.large)
                Text("You did't add any favorite Real Estates ! " )
                
            }
            .foregroundColor(.gray)
            Spacer()

        }else{
            VStack{
                ScrollView {
                    ForEach($firebaseRealEstateManger.bookMarkRealEstates) { $realEstate in
                        UserRealEstateView(realEstate: $realEstate, isItFavView: true)
                      
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

struct UserFavRealEstates_Previews: PreviewProvider {
    static var previews: some View {
        UserFavRealEstates()
            .environmentObject(FirebaseRealEstateManger())

    }
}
