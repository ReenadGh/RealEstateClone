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
        if (firebaseRealEstateManger.bookMarkRealEstates.isEmpty){
            ZStack{
                Label("You did't add any favorite Real Estates ! " , systemImage: "bed.double.circle")
                
            }.foregroundColor(Color(.label))
            
        }else{
                
                ScrollView {
                    ForEach($firebaseRealEstateManger.bookMarkRealEstates) { $realEstate in
                        UserRealEstateView(realEstate: $realEstate, isItFavView: true)
                      
                        .padding(10)

                    
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
