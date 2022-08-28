//
//  AddNewApplianceView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 25/01/1444 AH.
//

import SwiftUI

struct AddNewApplianceView: View {
    @Binding var newRealEstate : RealEstate

    var body: some View {
        VStack (alignment: .center, spacing: 12){
            HStack {
                
                
                Menu {
                    ForEach(0...10, id:\.self){ beds in
                        Button {
                            newRealEstate.beds = beds
                        } label: {
                            
                            switch beds {
                            case 0 :
                                Text("0 bed")
                            case 1 :
                                Text("\(beds) bed")
                            case 2... :
                                Text("\(beds) beds")
                            default:
                                Text("\(beds) beds")
                            }
                        }

                        
                    }
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "bed.double")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("beds")
                           
                        }
                        Text("\(newRealEstate.beds)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.orange).cornerRadius(12)
                }

                Menu{

                    ForEach(0...10, id:\.self){ baths in
                        Button {
                            newRealEstate.baths = baths
                        } label: {
                            
                            switch baths {
                            case 0 :
                                Text("0 bath")
                            case 1 :
                                Text("\(baths) bath")
                            case 2... :
                                Text("\(baths) baths")
                            default:
                                Text("\(baths) baths")
                            }
                        }

                        
                    }
                    
                }label: {
                    VStack(spacing : 4){
                        Image(systemName: "humidity.fill")
                    HStack (spacing : 2){
                        Image(systemName: "chevron.down")
                        Text("baths")
                    }
                        Text("\(newRealEstate.baths)")
                            .fontWeight(.heavy)
                }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.purple).cornerRadius(12)
                }
                              
                Menu {
                    
                    ForEach(1...8, id:\.self){ rooms in
                        Button {
                            newRealEstate.livingRooms = rooms
                        } label: {
                
                            switch rooms {
                            case 1 :
                                Text("\(rooms) room")
                            case 2... :
                                Text("\(rooms) rooms")
                            default:
                                Text("\(rooms) rooms")
                            }
                        }

                        
                    }
                    
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "bed.double.circle.fill")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("rooms")

                        }
                        Text("\(newRealEstate.livingRooms)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.gray).cornerRadius(12)
                }

                Menu {
                    ForEach((50...2000).filter{$0.isMultiple(of: 50)}, id:\.self){ space in
                        Button {
                            newRealEstate.space = space
                        } label: {
                
                            Text("\(space) M2")

                        }

                        
                    }
                    
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "bed.double")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("space")

                        }
                        Text("\(newRealEstate.space)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.blue).cornerRadius(12)
                }

         

            }.padding(.horizontal , 7)




            HStack{
                
                
                Menu {
                    ForEach(0...5, id:\.self){ ovens in
                        Button {
                            newRealEstate.ovens = ovens
                        } label: {
                            
                            switch ovens {
                            case 0 :
                                Text("0 oven")
                            case 1 :
                                Text("\(ovens) oven")
                            case 2... :
                                Text("\(ovens) ovens")
                            default:
                                Text("\(ovens) ovens")
                            }
                        }

                        
                    }
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "bed.double")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("Oven")
                        }
                        Text("\(newRealEstate.ovens)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.green).cornerRadius(12)
                }

        
                Menu {
                    ForEach(0...5, id:\.self){ fridges in
                        Button {
                            newRealEstate.fridges = fridges
                        } label: {
                            
                            switch fridges {
                            case 0 :
                                Text("0 fridge")
                            case 1 :
                                Text("\(fridges) fridge")
                            case 2... :
                                Text("\(fridges) fridges")
                            default:
                                Text("\(fridges) fridges")
                            }
                        }

                        
                    }
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "humidity.fill")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("Fridge")
             
                        }
                        Text("\(newRealEstate.fridges)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.brown).cornerRadius(12)
                }

                
                
                Menu {
                    ForEach(0...5, id:\.self){ micro in
                        Button {
                            newRealEstate.microwaves = micro
                        } label: {
                            
                            switch micro {
                            case 0 :
                                Text("0 microwave")
                            case 1 :
                                Text("\(micro) microwave")
                            case 2... :
                                Text("\(micro) microwaves")
                            default:
                                Text("\(micro) microwaves")
                            }
                        }

                        
                    }
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "bed.double.circle.fill")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("Micro")

                        }
                        Text("\(newRealEstate.microwaves)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.yellow).cornerRadius(12)
                }

         
                Menu {
                    ForEach(0...8, id:\.self){ AC in
                        Button {
                            newRealEstate.airConditions = AC
                        } label: {
                            
                            switch AC {
                            case 0 :
                                Text("0 AC")
                            case 1 :
                                Text("\(AC) AC")
                            case 2... :
                                Text("\(AC) AC")
                            default:
                                Text("\(AC) AC")
                            }
                        }

                        
                    }
                } label: {
                    VStack(spacing : 4){
                        Image(systemName: "wind")
                        HStack (spacing:2){
                            Image(systemName: "chevron.down")
                            Text("AC")
                        }
                        Text("\(newRealEstate.airConditions)")
                            .fontWeight(.heavy)
                    }
                    .frame(width: 90, height: 80)
                    .foregroundColor(.white)
                    .background(Color.pink).cornerRadius(12)
                }

   
       

            }.padding(.horizontal , 7)

        }
        
    }
}

struct AddNewApplianceView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewApplianceView(newRealEstate: .constant(realEstateExamble))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
