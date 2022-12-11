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
struct RealEstatesMapView: View {
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger

    @State var isAuthViewPresented : Bool = false
    @State var  selectedRealEstate : RealEstate = .init()

    @State var region : MKCoordinateRegion = .init(center: City.arrass.coordinate, span: City.arrass.extraZoomLevel)
  
    @State var logInSlideAnimation : Bool = true
    @StateObject var locationManger : LocationManager = LocationManager()
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
                        
                        RealEstatePinView(realEstate: $realEstate, selectedRealEstate: $selectedRealEstate)
                       
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
                                Image("house-icon")
                                    .resizable()
                                    .frame(width: 20, height: 20 )
                                    .foregroundColor(.white)

                            
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
                VStack (spacing : 10){
                    Image(systemName : "house.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("You can add realEstats, favorite, and more capabilities by logging in to the platform")
                        .font(.system(size : 15)).bold()
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button {
                        
                        isAuthViewPresented = true
                    } label: {
                        Text("Log in or Sign up here ")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.2))
                            .cornerRadius(12)
                    }

                }
                .padding(.top , 35)
                .padding()
            }
                .frame(maxWidth : .infinity )
                .background(Color.blue)
                .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                .ignoresSafeArea(.all, edges: .top)
                .isHidden(firebaseUserManger.isUserLogin(), remove: firebaseUserManger.isUserLogin())
                .offset(y :  logInSlideAnimation ? -200 : 0 )
                .opacity( logInSlideAnimation ? 0.5 : 1)
                .onAppear{
                    withAnimation(.spring(response: 2 , dampingFraction: 1 , blendDuration: 1 )){
                        logInSlideAnimation.toggle()
                    }
                }
          

            ,alignment: .top

                    )
            
                .fullScreenCover(isPresented: $isAuthViewPresented) {
                AuthView()
            }
            
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
                    
                    ,alignment: .trailing)
            
                .navigationBarHidden(true)

        }
        

    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        RealEstatesMapView()
            .environmentObject(FirebaseUserManger())
            .environmentObject(FirebaseRealEstateManger())

    }
}

struct RealEstatePinView: View {
    @Binding var realEstate : RealEstate
    @Binding var selectedRealEstate : RealEstate
    @State var popUpColor = Color(#colorLiteral(red: 0.1855567396, green: 0.2185586691, blue: 0.2209784687, alpha: 1))

    var body: some View {
        HStack{
             if (!realEstate.images.isEmpty){
            WebImage(url: URL(string: realEstate.images[0]))
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }else{
            
                                            ZStack{
                                                Image(systemName : realEstate.type.imageName)
                                                    .foregroundColor(.black)
            
                                            }
                                            .frame(width: 100, height: 120)
                                            .background(Color.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                        }
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
}
