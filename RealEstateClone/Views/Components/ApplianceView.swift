//
//  ApplianceView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 19/01/1444 AH.
//

import SwiftUI

struct ApplianceView: View {
    @Binding var realEstate : RealEstate

    var body: some View {
        VStack (alignment: .center, spacing: 12){
            HStack {
                VStack{
                    Image(systemName: "bed.double")
                    HStack {
                        Text("beds")
                        Text("\(realEstate.beds)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.orange).cornerRadius(12)

                VStack{
                    Image(systemName: "humidity.fill")
                    HStack {
                        Text("baths")
                        Text("\(realEstate.baths)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.purple).cornerRadius(12)
                VStack{
                    Image(systemName: "bed.double.circle.fill")
                    HStack {
                        Text("rooms")
                        Text("\(realEstate.livingRooms)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.gray).cornerRadius(12)
                VStack{
                    Image(systemName: "bed.double")
                    HStack {
                        Text("ovens")
                        Text("\(realEstate.ovens)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.blue).cornerRadius(12)

            }.padding(.horizontal , 9)




            HStack{
                VStack{
                    Image(systemName: "bed.double")
                    HStack {
                        Text("Oven")
                        Text("\(realEstate.beds)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.green).cornerRadius(12)

                VStack{
                    Image(systemName: "humidity.fill")
                    HStack {
                        Text("Fridge")
                        Text("\(realEstate.fridges)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.brown).cornerRadius(12)
                VStack{
                    Image(systemName: "bed.double.circle.fill")
                    HStack {
                        Text("Micro")
                        Text("\(realEstate.microwaves)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.yellow).cornerRadius(12)
                VStack{
                    Image(systemName: "wind")
                    HStack {
                        Text("AC")
                        Text("\(realEstate.airConditions)")
                    }
                }
                .frame(width: 85, height: 50)
                .foregroundColor(.white)
                .background(Color.pink).cornerRadius(12)

            }.padding(.horizontal , 9)

        }

    }
}

struct ApplianceView_Previews: PreviewProvider {
    static var previews: some View {
        ApplianceView(realEstate: .constant(realEstateExamble))
            .environmentObject(FirebaseUserManger())
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
