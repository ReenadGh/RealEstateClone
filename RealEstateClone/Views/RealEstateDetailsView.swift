//
//  RealEstateDetailsView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 19/01/1444 AH.
//

import SwiftUI
import LoremSwiftum
import AVKit
import MapKit
import SDWebImageSwiftUI


struct RealEstateDetailsView: View {
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @Binding var realEstate : RealEstate
    @State var selectedMediaType : MediaType = .photo
    @Binding var region : MKCoordinateRegion
    @State private var scaleMapAnnotation : Double = 0.0
    @State var  daysTimeSelection : [DayTimeSelection] = [
        .init(day: .friday, fromTime: Date(), toTime: Date()),
        .init(day: .saturday, fromTime: Date(), toTime: Date()),
        .init(day: .sunday, fromTime: Date(), toTime: Date()),
        .init(day: .monday, fromTime: Date(), toTime: Date()),
        .init(day: .tuesday, fromTime: Date(), toTime: Date()),
        .init(day: .wednesday, fromTime: Date(), toTime: Date()),
        .init(day: .thursday, fromTime: Date(), toTime: Date())
    ]
    var body: some View {
        ScrollView{
            
            
            Picker (selection : $selectedMediaType) {
                ForEach  (MediaType.allCases , id: \.self) { mediaType in
                    Text(mediaType.title)
                }
            } label: {
            }.labelsHidden().pickerStyle(.segmented).padding()

            
            switch selectedMediaType {
            case .photo:
                TabView {
                ForEach(realEstate.images , id: \.self){ image in
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width - 20, height:350 )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset( y: -28)
                }
                }.tabViewStyle(.page(indexDisplayMode: .always))
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .frame(height : 390)
            case .video:

                VideoPlayer(player: AVPlayer(url: URL(string: realEstate.videoStringURL)!))
                    .frame(width: UIScreen.main.bounds.width - 20, height:390)
                    .cornerRadius(20)
            }
           

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
                    Image("people-1")
                     .resizable()
                     .scaledToFill()
                     .frame(width: 60, height: 60, alignment: .center)
                     .clipShape(Circle())
                     .padding(8)
                     .overlay(Circle().stroke()
                        .foregroundColor(.gray)
                 )
                    Text(Lorem.firstName)
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
                                    Text("EMAIL")
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
            
            ForEach (daysTimeSelection , id : \.self) { dayTime in
                
                
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
            
    }
        .navigationTitle("Title")
        
    }
}

struct RealEstateDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView{
            RealEstateDetailsView( realEstate: .constant(realEstateExamble) , region: .constant(.init(center: City.arrass.coordinate , span: City.arrass.extraZoomLevel)) )
                .environmentObject(FirebaseUserManger())

            
        }
    }
}

