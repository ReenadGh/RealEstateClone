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
        
        if (firebaseRealEstateManger.userRealEstates.isEmpty){
            ZStack{
                Label("You did't add any Real Estates ! " , systemImage: "bed.double.circle")
                
            }
            
        }else{
                
                ScrollView {
                    ForEach($firebaseRealEstateManger.userRealEstates) { $realEstate in
                        UserRealEstateView(realEstate: $realEstate )
                        .padding(10)

                    
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
