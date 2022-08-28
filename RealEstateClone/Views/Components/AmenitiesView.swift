//
//  AmenitiesView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 19/01/1444 AH.
//

import SwiftUI

struct AmenitiesView: View {
    @Binding var realEstate : RealEstate
    var body: some View {
        
        VStack (spacing : 12){
        HStack(alignment: .center, spacing: 16 ){
            
            VStack (spacing :3){
                Image(systemName: "list.bullet.rectangle.portrait")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Smarts")
                Image(systemName:  realEstate.isSmart ? "checkmark.square.fill":"x.square.fill")
                    .imageScale(.large)
                    .foregroundColor(realEstate.isSmart ? .green: .red)
            }
            
            VStack (spacing : 3){
                Image(systemName: "wifi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Wifi")
                Image(systemName:  realEstate.hasWiFi ? "checkmark.square.fill":"x.square.fill")
                    .imageScale(.large)
                    .foregroundColor(realEstate.hasWiFi ? .green: .red)
            }
            
            VStack (spacing : 3){
                Image(systemName: "humidity.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Pool")
                Image(systemName:  realEstate.hasPool ? "checkmark.square.fill":"x.square.fill")
                    .imageScale(.large)
                    .foregroundColor(realEstate.hasPool ? .green: .red)
            }
            
            VStack (spacing : 3){
                Image(systemName: "arrow.up.and.person.rectangle.portrait")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Elevator")
                Image(systemName:  realEstate.hasElevator ? "checkmark.square.fill":"x.square.fill")
                    .imageScale(.large)
                    .foregroundColor(realEstate.hasElevator ? .green: .red)
            }
            
            
            VStack (spacing : 3){
                Image(systemName: "figure.wave")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("Gym")
                Image(systemName:  realEstate.hasGym ? "checkmark.square.fill":"x.square.fill")
                    .imageScale(.large)
                    .foregroundColor(realEstate.hasGym ? .green: .red)
            }

            
        }
        
        
        HStack(alignment: .center, spacing: 16 ){
            
            VStack (spacing :3){
                Image(systemName: "menucard")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Text("\(realEstate.age) Years")
               
            }
            
        }
        }
    }
}

struct AmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AmenitiesView( realEstate: .constant(realEstateExamble))
            .environmentObject(FirebaseUserManger())
            .padding()
            .previewLayout(.sizeThatFits)

    }
}
