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
    fileprivate func extractedFunc() -> Image {
        return Image("ellipsis")
    }
    
    var body: some View {
        
        
        NavigationLink{
            
            
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
           
           Menu {
               
               ForEach(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                   Button {
                       
                   } label: {
                       Text("otion \(item)")

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
          
       ,alignment: .topTrailing
       )
    }
}

struct UserRealEstateView_Previews: PreviewProvider {
    static var previews: some View {
        UserRealEstateView(realEstate: .constant(realEstateExamble))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
