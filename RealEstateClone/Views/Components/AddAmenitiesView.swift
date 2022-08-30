//
//  AddAmenitiesView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 25/01/1444 AH.
//

import SwiftUI

struct AddAmenitiesView: View {
    @Binding var newRealEstate : RealEstate
    var body: some View {
        VStack (spacing : 12){
        HStack(alignment: .center, spacing: 16 ){
            
            Button {
                newRealEstate.isSmart.toggle()
            } label: {
                VStack (spacing :3){
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Smarts")
                    Image(systemName:  newRealEstate.isSmart ? "checkmark.square.fill":"square")
                        .imageScale(.large)
                        .foregroundColor(newRealEstate.isSmart ? .green: .white)
                }.foregroundColor(.white)
            }

            
            Button {
                newRealEstate.hasWiFi.toggle()
            } label: {
                VStack (spacing : 3){
                    Image(systemName: "wifi")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Wifi")
                    Image(systemName:  newRealEstate.hasWiFi ? "checkmark.square.fill":"square")
                        .imageScale(.large)
                        .foregroundColor(newRealEstate.hasWiFi ? .green: .white)
                }.foregroundColor(.white)
            }

            
            Button {
                newRealEstate.hasPool.toggle()
            } label: {
                VStack (spacing : 3){
                    Image(systemName: "humidity.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Pool")
                    Image(systemName:  newRealEstate.hasPool ? "checkmark.square.fill":"square")
                        .imageScale(.large)
                        .foregroundColor(newRealEstate.hasPool ? .green: .white)
                }.foregroundColor(.white)
            }

            
            Button {
                newRealEstate.hasElevator.toggle()
            } label: {
                VStack (spacing : 3){
                    Image(systemName: "arrow.up.and.person.rectangle.portrait")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Elevator")
                    Image(systemName:  newRealEstate.hasElevator ? "checkmark.square.fill":"square")
                        .imageScale(.large)
                        .foregroundColor(newRealEstate.hasElevator ? .green: .white)
                }.foregroundColor(.white)
            }

            
            
            Button {
                newRealEstate.hasGym.toggle()
            } label: {
                VStack (spacing : 3){
                    Image(systemName: "figure.wave")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Text("Gym")
                    Image(systemName:  newRealEstate.hasGym ? "checkmark.square.fill":"square")
                        .imageScale(.large)
                        .foregroundColor(newRealEstate.hasGym ? .green: .white)
                }.foregroundColor(.white)
            }


            
        }
        
        
        HStack(alignment: .center, spacing: 16 ){
            
            Menu {
                
                ForEach(0...20 , id: \.self){ year in
                    Button {
                        newRealEstate.age = year
                    } label: {
                        
                        switch year {
                        case 0:
                            Text("0 year")
                        case 1:
                            Text("1 years")
                        case 2...:
                            Text("\(year) years")
                        default:
                            Text("\(year) years")
                        }
                        Text("year")
                    }

                    
                }
                
            } label: {
                VStack (spacing :3){
                    Image(systemName: "menucard")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    HStack (spacing : 3){
                        Image(systemName: "chevron.down")
                        Text("\(newRealEstate.age) Years")
                    }
                   
                }.foregroundColor(.white)
            }

            
        }
        }
        
        
    }
}

struct AddAmenitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AddAmenitiesView(newRealEstate: .constant(realEstateExamble))
            .previewLayout(.sizeThatFits)
    }
}
