//
//  SampleNewRealEstate.swift
//  RealEstateClone
//
//  Created by Reenad gh on 27/01/1444 AH.
//


import SwiftUI
import LoremSwiftum
import AVKit
import MapKit
import SDWebImageSwiftUI

struct SampleNewRealEstate: View {
    
        @EnvironmentObject var firebaseUserManger : FirebaseUserManger
        @EnvironmentObject var firebaseRealEstateManger : FirebaseRealEstateManger

        @Binding var realEstate : RealEstate
        @Binding var images : [UIImage]
        @Binding var VideoURL : URL?
        @Binding var isAddNewEstateViewPresented : Bool

        @State var isloading : Bool = false
        @State var selectedMediaType : MediaType = .photo
        @State private var scaleMapAnnotation : Double = 0.0
        @State var region : MKCoordinateRegion = .init()

        var body: some View {
            ScrollView{
                
                Group {
                Picker (selection : $selectedMediaType) {
                    ForEach  (MediaType.allCases , id: \.self) { mediaType in
                        Text(mediaType.title)
                    }
                } label: {
                }.labelsHidden().pickerStyle(.segmented).padding()

                }
                Group {
                switch selectedMediaType {
                case .photo:
                    
                    if !images.isEmpty {
                    TabView {
                    ForEach(images , id: \.self){ uiImage in
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width - 20, height:350 )
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset( y: -28)
                    }
                    }.tabViewStyle(.page(indexDisplayMode: .always))
                        .indexViewStyle(.page(backgroundDisplayMode: .always))
                        .frame(height : 390)
                        
                    }else {
                        ZStack{
                            Label("There is no photos" , systemImage: "photo")
                        }
                        .frame(height : 390)
                        
                    }
                case .video:

                    if let videoURL = VideoURL {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(width: UIScreen.main.bounds.width - 20, height:390)
                        .cornerRadius(20)
                    }else {
                        ZStack{
                            Label("There is no video" , systemImage: "video.fill")
                        }
                        .frame(height : 390)
                        
                    }
                }
               
                }
                
                Group{
                VStack (alignment: .leading) {
                    HStack {
                        Text("Info")
                            .font(.title)
                            .fontWeight(.heavy)
                        .foregroundColor(.gray)
                        .padding(.leading , 12)
                        Spacer()

                    }
                    .padding(.bottom , 1)

                    Text(realEstate.description)
                        .font(.system(size: 17 , weight: .semibold))
                        .padding(.horizontal , 12)

                }

                Divider()
                    .padding(.horizontal , 70)
                    .padding(.vertical , 20)


                VStack (alignment: .center) {
                    HStack {
                        Text("Appliance")
                            .font(.title)
                            .fontWeight(.heavy)
                        .foregroundColor(.gray)
                        .padding(.leading , 12)
                        Spacer()

                    }
                    .padding(.bottom , 14)


                    ApplianceView(realEstate: $realEstate)
                }

                Divider()
                    .padding(.horizontal , 70)
                    .padding(.vertical , 20)

                VStack (alignment: .center , spacing : 15 ) {
                    HStack {
                        Text("Amenities")
                            .font(.title)
                            .fontWeight(.heavy)
                        .foregroundColor(.gray)
                        .padding(.leading , 12)
                        Spacer()


                    }
                    .padding(.bottom , 8)

                    AmenitiesView(realEstate: $realEstate)


                }
                    
                }
                
                Divider()
                    .padding(.horizontal , 70)
                    .padding(.vertical , 20)

                VStack (alignment: .center , spacing : 15 ) {
                    HStack {
                        Text("Location")
                            .font(.title)
                            .fontWeight(.heavy)
                        .foregroundColor(.gray)
                        .padding(.leading , 12)
                        Spacer()


                    }
                    .padding(.bottom , 8)
                    Map(coordinateRegion: $region, annotationItems: [realEstate]) { realEstate in
                        MapAnnotation(coordinate: realEstate.location) {

                            VStack (spacing : 10) {

                                Text("\(realEstate.price) SR")

                                    .padding()
                                    .background(Material.ultraThinMaterial).cornerRadius(20)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue))

                                ZStack {
                                    Circle()
                                        .frame(width: 20, height: 20)
                                    .foregroundColor(.blue)
                                    Circle()
                                        .frame(width: 70, height: 70)
                                    .foregroundColor(.blue)
                                    .opacity(0.3)
                                    .scaleEffect(scaleMapAnnotation)
                                    .animation(Animation.easeOut(duration: 3).repeatForever(autoreverses: false), value: scaleMapAnnotation)

                                    .onAppear{

                                            scaleMapAnnotation = 1
                                         }

                                }
                            }


                        }
                    }.frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .cornerRadius(20)

                    Divider()
                        .padding(.horizontal , 70)
                        .padding(.vertical , 20)
                }
                
       
                
                            VStack (alignment: .center) {
                                HStack {
                                    Text("Contact")
                                        .font(.title)
                                        .fontWeight(.heavy)
                                    .foregroundColor(.gray)
                                    .padding(.leading , 12)
                                    Spacer()
                
                                }
                                .padding(.bottom , 1)
                HStack{
                    VStack {
                        WebImage(url: URL(string: firebaseUserManger.user.profileImageUrl))
                         .resizable()
                         .scaledToFill()
                         .frame(width: 60, height: 60, alignment: .center)
                         .clipShape(Circle())
                         .padding(8)
                         .overlay(Circle().stroke()
                            .foregroundColor(.gray)
                     )
                        Text(firebaseUserManger.user.username)
                            .font(.footnote)
                            .frame(width: 60, height:20)

                    }
                    VStack {
                        HStack{
                            Button {


                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundColor(.blue)
                                    .frame(width: 150, height: 40)

                                    HStack {
                                        Image(systemName: "envelope.fill")
                                            .foregroundColor(.white)
                                        Text(firebaseUserManger.user.email)
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)

                                    }
                                }
                            }.buttonStyle(.borderless)

                            Button {


                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .foregroundColor(.green)
                                    .frame(width: 150, height: 40)

                                    HStack {
                                        Image(systemName: "phone.fill")
                                            .foregroundColor(.white)
                                        Text("WhatsApp")
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)

                                    }
                                }
                            }.buttonStyle(.borderless)

                        }



                        Button {


                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .foregroundColor(.purple)
                                .frame(width: 300, height: 40)

                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.white)
                                        .imageScale(.large)
                                    Text(firebaseUserManger.user.phoneNumber)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                        }.buttonStyle(.borderless)
                    }
                }
                
                                ForEach (firebaseUserManger.user.dayTimeAvailability , id : \.self) { dayTime in
                    
                    
                    HStack( spacing: 20){
                        
                        Text(dayTime.day.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text(dayTime.fromTime.convertDate(formattedString: .timeOnly))
                        Text("-")
                        Text(dayTime.toTime.convertDate(formattedString: .timeOnly))

                    }.padding(10).background(Color(.systemGray6)).cornerRadius(10).padding(.horizontal , 25).padding(.vertical , 2)

                }
                
                            }
                
                Button {

                    isloading.toggle()

                    realEstate.ownerId = firebaseUserManger.user.id
                    firebaseRealEstateManger.addRealEstate(realEstate: realEstate, images: images, videoURL: VideoURL) { isSecces in
                        
                        if isSecces {
                            print("DEBUG : reale Estate aadded to store! ")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                isloading.toggle()
                                isAddNewEstateViewPresented = false

                            }
                            
                        }else {
                            isloading.toggle()
                            print(" DEBUG : not able to add reale Estate to store   ")

                        }
                        
                    }
       


                } label: {
                    Text("upload my RealEstate ")
                        .foregroundColor(.blue)
                        .fontWeight(.bold)
                        .frame(width: 300, height: 50)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            
                            .stroke(Color.blue , lineWidth: 2)
                            
                            )
                        .cornerRadius(12)
            }
                
        }
            .navigationTitle("Title")
            .onAppear{
                
                region.center = realEstate.location
                region.span = realEstate.city.extraZoomLevel

            }
            
            .overlay(
                customProgressView().isHidden(!isloading, remove: !isloading)
            )
            
    }
}

struct SampleNewRealEstate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SampleNewRealEstate( realEstate: .constant(realEstateExamble)  , images: .constant([UIImage(named: "Image1")!,UIImage(named :"Image2")!]),VideoURL: .constant(URL(string:"")), isAddNewEstateViewPresented: .constant(true))
                .environmentObject(FirebaseRealEstateManger())
                .environmentObject(FirebaseUserManger())

        }
    }
}
