//
//  HomeView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 14/01/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI
import MapKit
import LoremSwiftum
struct HomeView: View {
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger

    @State var isProfileViewPresented : Bool = false
    @State var isAuthViewPresented : Bool = false
    @State var isAddNewEstateViewPresented : Bool = false
    @State var  showRealEstateDetailView : Bool = false
    @State var  selectedRealEstate : RealEstate = .init()

    @State var region : MKCoordinateRegion = .init(center: City.arrass.coordinate, span: City.arrass.extraZoomLevel)
  
    
    @StateObject var locationManger : LocationManager = LocationManager()
    @State var popUpColor = Color(#colorLiteral(red: 0.1855567396, green: 0.2185586691, blue: 0.2209784687, alpha: 1))
    var body: some View {
    
            
            
        NavigationView {
            Map(coordinateRegion: $locationManger.region,
                interactionModes: .all ,
                showsUserLocation: true ,
                annotationItems : $firebaseRealEstateManger.realEstates ){ $realEstate in
                
                
                MapAnnotation(coordinate: realEstate.location) {
                   NavigationLink {
                       
                       RealEstateDetailsView(realEstate: $realEstate )
                       
                           .onDisappear{
                               
                               locationManger.region.span = .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
                           }
                    } label: {
                        
                        HStack{
                           // if (!RealEstate.images.isEmpty){
                            WebImage(url: URL(string: realEstate.images[0]))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                            }else{
//
//                                ZStack{
//                                    Image(systemName : realEstate.type.imageName)
//                                        .foregroundColor(.black)
//
//                                }
//                                .frame(width: 100, height: 120)
//                                .background(Color.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 20))
//                            }
                            Divider()
                            Spacer()
                            
                            
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
                                
                                
                                HStack{
                                    Image(systemName : realEstate.type.imageName)
                                        .foregroundColor(.white)
                                        .imageScale(.large)
                                    Text(realEstate.type.title)
                                        .font(.system(size : 14 ,weight : .semibold))

                                }
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
                                Spacer()
                            }
                        }.frame(width:350)
                            .padding(12)
                            .foregroundColor(.white)
                            .background(popUpColor).cornerRadius(12)
                            .overlay(
                                Button {
                                    selectedRealEstate = RealEstate()
                                } label: {
                                    Image(systemName :"eye.slash")
                                        .foregroundColor(.yellow)
                                        .imageScale(.large)
                                        .padding(.top , 10)
                                        .padding(.trailing , 10)
                                },alignment : .topTrailing
                                      )
                            .scaleEffect(selectedRealEstate == realEstate ? 1: 0)
                            .opacity(selectedRealEstate == realEstate ? 1: 0)
                            .animation(.spring(), value: selectedRealEstate == realEstate)
                       
                    }

                        
                    
                    Button {
                        withAnimation{ locationManger.region.center = realEstate.location
                            
                            
                        }
                        
                        selectedRealEstate = realEstate
                        
                        
                    } label: {
                        
                        
                        VStack (spacing: 0) {
                            HStack {
                                Button {
                                    
                                } label: {
                                    Image(systemName : "info.circle")
                                        .foregroundColor(.white)
                                        .imageScale(.large)
                                }

                                Text ("\(realEstate.price) SR")
                                    .foregroundColor(.white)
                                Image(systemName : "house")
                                    .foregroundColor(.white)
                                    .imageScale(.large)
                            
                            }.padding()
                                .background(Color.blue.cornerRadius(30))
                            
                            Triangle()
                                .fill(.blue)
                                .frame(width: 30, height: 30)
                                .rotationEffect(.init(degrees:180))
                        }
                    }

                    
                    

                       

                }
            }
                .ignoresSafeArea()
                .preferredColorScheme(.dark)
                .onAppear{

                    firebaseUserManger.fetchUser()

                }
                .overlay(
            HStack {
                Spacer()
               
                Button {
                    print("pressed")
                    isAddNewEstateViewPresented = true
                } label: {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add New Estat")
                    } .isHidden(firebaseUserManger.isUserLogin(), remove: firebaseUserManger.isUserLogin())

                }.padding(45).padding(.top , 30)
            }
                .frame( height: 130)
                .background(Material.ultraThinMaterial)
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea(.all, edges: .top)

            
            
                .fullScreenCover(isPresented: $isProfileViewPresented) {
                ProfileView()
            }
            
                .fullScreenCover(isPresented: $isAddNewEstateViewPresented) {
                AddRealEstateView(isAddNewEstateViewPresented: $isAddNewEstateViewPresented)
            }
            
                .fullScreenCover(isPresented: $isAuthViewPresented) {
                AuthView()
            }

            ,alignment: .top

                    )
            
                .overlay(
                    Button{
                    
                    if (firebaseUserManger.user.id == ""){
                        isAuthViewPresented = true
                    }else{
                    isProfileViewPresented = true
                    }
                }label: {
                    WebImage(url: URL(string: firebaseUserManger.user.profileImageUrl))
                     .resizable()
                     .scaledToFill()
                     .frame(width: 90, height: 90, alignment: .center)
                     .clipShape(Circle())
                     .padding(8)
                     .overlay(Circle().stroke()
                        .foregroundColor(.gray)
                 )
                }.padding(.leading , 30) .padding(.top , 18), alignment:.topLeading)
            
            
                .overlay(
                    
                    VStack(spacing : 40){
                        Button {
                            
                            if let center = locationManger.userLocation?.coordinate{
                                withAnimation{
                                locationManger.region.center = center
                                }
                            }
                        } label: {
                            Image(systemName:"scope")
                                .imageScale(.large)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName:"line.3.horizontal.decrease")
                                .imageScale(.large)

                            
                        }

                    }                    .padding(8).background(Material.ultraThinMaterial).cornerRadius(20)
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.white.opacity(0.5),lineWidth: 1)
                            
                        )
                        .padding()
                    
                ,alignment: .bottomTrailing)
            
                .navigationBarHidden(true)

        }
        

    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(FirebaseUserManger())
            .environmentObject(FirebaseRealEstateManger())

    }
}
