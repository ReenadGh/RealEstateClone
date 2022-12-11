//
//  MainView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 11/05/1444 AH.
//

import SwiftUI

enum AppScreens  : CaseIterable{
    case favoriteRealEstats
    case userRealEstats
    case newRealEstate
    case realEstatsMap
    case userProfile

    var img : String {
        switch self {
        case .favoriteRealEstats:
            return "star.fill"
        case .userRealEstats:
            return "house.fill"
        case .newRealEstate:
            return "plus"
        case .realEstatsMap:
            return "map.fill"

        case .userProfile:
            return "person.fill"
        }
    }
}
struct MainView: View {
    @State var selectedSection : AppScreens = .realEstatsMap
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger
    
    var body: some View {

        
        ZStack {
            switch selectedSection {
            case .favoriteRealEstats:
                UserFavRealEstates()
            case .userRealEstats:
                UserRealEstatesListView()
            case .newRealEstate:
                AddRealEstateView( isAddNewEstateViewPresented: .constant(true))
            case .realEstatsMap:
                RealEstatesMapView()
            case .userProfile:
                UserProfileView( selectedSection: $selectedSection)
            }

            VStack {
                Spacer()
                RealEstatesTabView(selectedSection: $selectedSection)
                    .padding()
                    .isHidden(!firebaseUserManger.isUserLogin(), remove: !firebaseUserManger.isUserLogin())
            }

        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(FirebaseUserManger())
            .environmentObject(FirebaseRealEstateManger())

            
    }
}

struct RealEstatesTabView: View {
    @Namespace var animation
    @Binding var selectedSection : AppScreens
    var body: some View {
        HStack (alignment: .center ,  spacing : 20  ) {
            
            ForEach(AppScreens.allCases , id : \.self){ section in
                Button  {
                    withAnimation (.spring(response: 1, dampingFraction: 0.7, blendDuration: 0.2)) {
                        selectedSection = section

                    }
                } label: {
                    
                    if (selectedSection == section ) {
                        Image(systemName : section.img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20 )
                            .foregroundColor(.white)
                      

                            .background(

                                Color.black
                                    .frame(width: 40, height: 40 )
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                .matchedGeometryEffect(id: "tab", in: animation)
                                
                                
                            )
                            .padding(.horizontal)
                            .padding(.vertical , 10)

                    }else {
                        Image(systemName : section.img)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20 )
                       
                            .foregroundColor(.white)

                           
                  
                            .id("icon")
                            .padding(.horizontal)
                            .padding(.vertical , 10)

                            
                    }
                  
                    
                    
           
                }

         

                
            }
        }
        .padding(10)
        .background(Color.blue)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 30)
    }
}
