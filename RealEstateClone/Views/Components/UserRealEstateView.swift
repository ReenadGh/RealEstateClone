//
//  UserRealEstateView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 07/02/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserRealEstateView: View {
    @Binding var realEstate : RealEstate
    @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger
    var isItFavView : Bool = false
    fileprivate func extractedFunc() -> Image {
        return Image("ellipsis")
    }
    
    var body: some View {
        
        
        NavigationLink{
            
            RealEstateDetailsView(realEstate: $realEstate)
        }label: {
            HStack{
                if (!realEstate.images.isEmpty){
                    WebImage(url: URL( string: realEstate.images.first ?? ""))
                .resizable()
                .frame(width: 120, height: 120)
                .cornerRadius(12)
                }else{
                    ZStack{
                        Image(systemName: "photo")
                    }.frame(width: 120, height: 120)
                        .cornerRadius(12)
        
                }
                
                VStack(alignment:.leading ,spacing : 7){
                    HStack {
                        Text("\(realEstate.price) SR")
                        Text("·")
                        Image(systemName : realEstate.saleCategory.imageName)
                            .foregroundColor(.white)
                        Text(realEstate.saleCategory.title)
                            .foregroundColor(.cyan)
                        

                    }
                    
                    Text(realEstate.description)
                        .font(.system(size : 13 ,weight : .semibold))
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                 
                    Divider()
                    
                    HStack{
                        
                        HStack{
                            Image(systemName: "bed.double")
                            Text("\(realEstate.beds)")
                            
                        }
                        .font(.system(size : 12 ,weight : .semibold))
                        .frame(width: 50,height:28)
                            .background(Color.blue).cornerRadius(12)
                        
                        HStack{
                            Image(systemName: "comb.fill")
                            Text("\(realEstate.baths)")

                        }                                  .font(.system(size : 12 ,weight : .semibold))
                            .frame(width: 50,height:28)
                                .background(Color.purple).cornerRadius(12)
                        
                        HStack{
                            Image(systemName: "photo.fill")
                            Text("\(realEstate.images.count)")

                        }  .font(.system(size : 12 ,weight : .semibold))
                            .frame(width: 50,height:28)
                                .background(Color.gray).cornerRadius(12)
                        HStack{
                            Image(systemName: "ruler.fill")
                            Text("\(realEstate.livingRooms)")

                        }  .font(.system(size : 12 ,weight : .semibold))
                            .frame(width: 50,height:28)
                                .background(Color.orange).cornerRadius(12)
                        
                    }
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .opacity(0.6)
                            

            }.foregroundColor(Color(.label))
            
        }
        .overlay(
           
            ZStack{
            if !isItFavView{
                
                // in UserReealEstates View
           Menu {
               
               ForEach(SaleCategory.allCases , id: \.self) { type in
                   Button {
                       switch type{
                       case .sale :
                           realEstate.saleCategory = .sale
                           if realEstate.isAvailable {
                               realEstate.isAvailable = false
                               firebaseRealEstateManger.markRealEstate(realEstate: realEstate)
                           }else{
                               realEstate.isAvailable = true
                               firebaseRealEstateManger.reAddRealEstate(realEstate: realEstate)
                           }
                       case .investment :
                           realEstate.saleCategory = .investment
                           if realEstate.isAvailable {
                               realEstate.isAvailable = false
                               firebaseRealEstateManger.markRealEstate(realEstate: realEstate)
                           }else{
                               realEstate.isAvailable = true
                               firebaseRealEstateManger.reAddRealEstate(realEstate: realEstate)
                           }
                       case .rent :
                           realEstate.saleCategory = .rent
                           if realEstate.isAvailable {
                               realEstate.isAvailable = false
                               firebaseRealEstateManger.markRealEstate(realEstate: realEstate)
                           }else {
                               realEstate.isAvailable = true
                               firebaseRealEstateManger.reAddRealEstate(realEstate: realEstate)
                           }
                       }
                   } label: {
                       
                       if realEstate.isAvailable {
                       Label("Mark as \(type.markedTitle)" , systemImage: type.imageName)
                       }else{
                           
                           Label("Offer for \(type.title)" , systemImage: type.imageName)
                           

                       
                       }
                   }

               }
               Divider()
               Button (role: .destructive) {
                   
               } label: {
                   Label("Delete", systemImage: "trash")
                       .foregroundColor(.red)
               }

           } label: {
                  Image(systemName: "ellipsis")
                   .foregroundColor(Color(.label))
           }
                
            }else{
                
                // in UserFavReealEstates View

                Button (role: .destructive) {
                    firebaseRealEstateManger.removeMarkRealEstate(realEstate: realEstate)
                    
                } label: {
                    Label("remove", systemImage: "bookmark")

                }

                
                
            }
          
            }  , alignment: .topTrailing
       )
        
        .overlay(
        
            Text(realEstate.saleCategory.markedTitle)
                .font(.system(size : 20 ))
                .frame(width: 300 , height: 40)
                .background(realEstate.saleCategory.saleColor                .opacity(0.9)
)
                .cornerRadius(20)
                .rotationEffect(.init(degrees: -12))
                .isHidden(realEstate.isAvailable, remove:realEstate.isAvailable)
        
        )
    }
}

struct UserRealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        UserRealEstateView(realEstate: .constant(realEstateExamble), isItFavView: true)
            .padding()
            .previewLayout(.sizeThatFits)
            .environmentObject(FirebaseRealEstateManger())

    }
}
