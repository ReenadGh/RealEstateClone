//
//  AddRealEstate.swift
//  RealEstateClone
//
//  Created by Reenad gh on 21/01/1444 AH.
//

import SwiftUI
import PhotosUI
import AVKit
import LoremSwiftum
import MapKit
class addRealEstateModel : ObservableObject {
    @Published var newRealEstate = RealEstate()
    @Published var images : [UIImage] = []
    @Published var isShowingVideoPicker : Bool = false
    @Published var videoURL : URL?
    @Published var refreshMapViewId  = UUID()
    @Published var coordinateRegion  : MKCoordinateRegion =       MKCoordinateRegion(center: City.arrass.coordinate, latitudinalMeters: City.arrass.zoomLevel.latitudeDelta, longitudinalMeters: City.arrass.zoomLevel.longitudeDelta)

}
struct AddRealEstateView: View {
    @State var newRealEstate : RealEstate = RealEstate()
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var  viewModel = addRealEstateModel()
    @State var inputImgs : [UIImage] = []
    @State private var showingImagesPicker = false

    
    @Binding var isAddNewEstateViewPresented : Bool 

    var body: some View {
        NavigationView {
            ScrollView {
                 Group{
                     VStack(spacing : 0){
                     HStack{
                    Text("Location")
                        .font(.system(size: 25 , weight: .bold))
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.top , 8)
                    Menu{
                        ForEach(City.allCases , id: \.self){ city in
                            Button {
                                viewModel.newRealEstate.city = city
                                viewModel.coordinateRegion = MKCoordinateRegion(center: city.coordinate, latitudinalMeters: city.zoomLevel.latitudeDelta, longitudinalMeters: city.zoomLevel.longitudeDelta)
                            } label: {
                                Text(city.title)
                            }
                        }
                    }label: {
        
                        HStack{
                           Text("City")
                                .foregroundColor(.white)
                            .font(.system(size: 19 , weight: .heavy))
                            Spacer()
                        Text(viewModel.newRealEstate.city.title)
                            Image(systemName:"chevron.down")
                        }.padding(10).background(Color(.systemGray6)).cornerRadius(10).padding(.vertical , 2)

                    }
                 
                     }.padding(.horizontal , 15)
                     VStack(spacing : 0){
                  
                         HStack{
                    Text("Type")
                        .font(.system(size: 25 , weight: .bold))
                        .foregroundColor(.gray)
                    Spacer()
                }

                    Menu{
                        ForEach(RealEstateType.allCases , id: \.self){ type in
                            Button {
                                viewModel.newRealEstate.type = type
                            } label: {
                                HStack {
                                    Text(type.title)
                                    Image(systemName: type.imageName)
                                }
                            }
                        }
                    }label: {
                        HStack{
                           Text("Category")
                                .foregroundColor(.white)
                            .font(.system(size: 19 , weight: .heavy))
                            Spacer()
                            HStack {
                                Image(systemName:viewModel.newRealEstate.type.imageName)
                                Text(viewModel.newRealEstate.type.title)
                            }
                            Image(systemName:"chevron.down")
                        }.padding(10).background(Color(.systemGray6)).cornerRadius(10).padding(.vertical , 2)

                    }

                     }.padding(.horizontal , 15)
                     VStack(spacing : 0){
                     HStack{
                    Text("Sale")
                        .font(.system(size: 25 , weight: .bold))
                        .foregroundColor(.gray)
                    Spacer()
                }

                    Menu{
                        ForEach(SaleCategory.allCases , id: \.self){ sale in
                            Button {
                                viewModel.newRealEstate.saleCategory = sale
                            } label: {
                                Text(sale.title)
                            }
                        }
                    }label: {
                        HStack{
                           Text("Offer")
                                .foregroundColor(.white)
                            .font(.system(size: 19 , weight: .heavy))
                            Spacer()
                        Text(viewModel.newRealEstate.saleCategory.title)
                            Image(systemName:"chevron.down")
                        }.padding(10).background(Color(.systemGray6)).cornerRadius(10).padding(.vertical , 2)

                    }

                     }.padding(.horizontal , 15)
                     VStack(spacing : 0){
                   HStack{
                    Text("Duration")
                        .font(.system(size: 25 , weight: .bold))
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.vertical , 8)

                    Menu{
                        ForEach(OfferType.allCases , id: \.self){ duration in
                            Button {
                                viewModel.newRealEstate.offer = duration
                            } label: {
                                Text(duration.title)
                            }
                        }
                    }label: {
                        HStack{
                           Text("Time")
                                .foregroundColor(.white)
                            .font(.system(size: 19 , weight: .heavy))
                            Spacer()
                        Text(viewModel.newRealEstate.offer.title)
                            Image(systemName:"chevron.down")
                        }.padding(10).background(Color(.systemGray6)).cornerRadius(10).padding(.vertical , 2)

                    }
                     }.padding(.horizontal , 15)
                     
                }
                Group {
                    VStack{
                    HStack{
                        Text("Price")
                            .font(.system(size: 25 , weight: .bold))
                            .foregroundColor(.gray)
                        Spacer()


                    }.padding(.vertical , 8)


                    TextField("0.0", value:  $viewModel.newRealEstate.price , format : .number).font(.system(size: 15 , weight: .bold))
                     .padding(10)
                     .background(Color(.systemGray6))
                     .cornerRadius(10)
                    .padding(.vertical , 2)

                    }.padding(.horizontal , 15)
                }
                Group{
                    VStack(spacing : 0) {
                HStack{
               Text("Photos")
              .font(.system(size: 25 , weight: .bold))
              .foregroundColor(.gray)
               Spacer()


                }.padding(.vertical , 8)

                LazyVGrid(columns: [GridItem.init(.adaptive(minimum: 140))] ){
                    ForEach(viewModel.images , id : \.self ) { item in
                        VStack {
                            Image(uiImage: item)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 170, height:170 )
                            .clipShape(RoundedRectangle(cornerRadius: 12))

                            Button {

                                withAnimation{
                                    if let indexofDeletedImg =  viewModel.images.firstIndex(of: item){
                                        viewModel.images.remove(at: indexofDeletedImg)}
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .frame(width: 160, height: 35)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.red , lineWidth: 1.5)
                                    )
                                    .foregroundColor(.red)

                            }




                        }.padding(.vertical , 7)
                    }



                    Button {

                        showingImagesPicker = true

                    } label: {
                        VStack {
                            VStack(spacing : 20){

                                Image(systemName: viewModel.images.count == 0 ? "icloud.and.arrow.up" : "plus")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 60)
                                Label(viewModel.images.count == 0 ? "Upload Photos" : "Add More" , systemImage: "photo")
                            }

                            .frame(width: 170, height:170 )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash:[10]))
                        )
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.clear)
                                .frame(width: 170, height: 35)



                        }

                    }

                    .sheet(isPresented: $showingImagesPicker) {
                        ImagesPicker(pickerResult: $viewModel.images, isPresented: $showingImagesPicker)

                    }

                }
                    }.padding(.horizontal , 15)

                }
                Group{
                    VStack(spacing : 0){
                HStack{
                    
               Text("Video")
              .font(.system(size: 25 , weight: .bold))
              .foregroundColor(.gray)
               Spacer()


                }.padding(.vertical , 8)




                if let videoURL = viewModel.videoURL {
                    VStack {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(width: UIScreen.main.bounds.width - 40, height: 160)

                        Button {
                            withAnimation{
                                viewModel.videoURL = nil
                            }

                        } label: {
                            Label("Delete", systemImage: "trash")
                                .frame(width: 160, height: 35)
                                .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.red , lineWidth: 1.5)
                                )
                                .foregroundColor(.red)
                        }

                    }
                }

                Button {

                    viewModel.isShowingVideoPicker.toggle()
                } label: {

                        VStack(spacing : 20){

                            Image(systemName:  "icloud.and.arrow.up")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 60)
                            Label("Upload Video" , systemImage: "pause.circle")
                        }
                        .frame(width: UIScreen.main.bounds.width - 40, height: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash:[10]))
                    )



                }
                .isHidden(viewModel.videoURL != nil , remove: viewModel.videoURL != nil)
                .mediaImporter(isPresented: $viewModel.isShowingVideoPicker, allowedMediaTypes: .videos) { result in

                    switch result{
                    case .success(let videoURL):
                        DispatchQueue.main.async {
                            viewModel.videoURL = videoURL
                        }
                    case .failure(let error):
                     print(error)

                    }



                }
                    }.padding(.horizontal , 15)
                }
                Group{
                 
                HStack{
               Text("Appliance")
              .font(.system(size: 25 , weight: .bold))
              .foregroundColor(.gray)
               Spacer()


                }.padding(.vertical , 8).padding(.horizontal , 15)
                AddNewApplianceView(newRealEstate: $viewModel.newRealEstate)
                    
                }
                Group{
                    VStack(spacing : 0){
                HStack{
               Text("Info")
              .font(.system(size: 25 , weight: .bold))
              .foregroundColor(.gray)
               Spacer()


                }.padding(.vertical , 8)


                TextField("info about Estate", text: $viewModel.newRealEstate.description)
                    .padding()
                    .frame( minHeight : 100)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    }.padding(.horizontal , 15)
                }
                Group{
                HStack{
               Text("Amenities")
              .font(.system(size: 25 , weight: .bold))
              .foregroundColor(.gray)
               Spacer()


                }.padding(.vertical , 8).padding(.horizontal , 15)


                AddAmenitiesView(newRealEstate: $viewModel.newRealEstate)
                    

                }
                Group{
      HStack{
            Text("Location")
          .font(.system(size: 25 , weight: .bold))
                                            .foregroundColor(.gray)
                                        Spacer()
                
                
                                    }.padding(.vertical , 8).padding(.horizontal , 15)
           
           MapUIKitView(realEstate: $viewModel.newRealEstate)
               .frame(width: UIScreen.main.bounds.width-40, height: 250 )
               .id(viewModel.refreshMapViewId)
               .onChange(of: viewModel.newRealEstate.city) {_ in
                   viewModel.refreshMapViewId = UUID()
               }
               .cornerRadius(30)
               .overlay(
               Image(systemName: "mappin.and.ellipse")
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 40, height: 40)
               )
             
    
           Text("LAT : \(viewModel.newRealEstate.location.latitude)     LON : \(viewModel.newRealEstate.location.longitude)")
           Text("")
       }
       
                Group {
                    Divider()
                        .padding()
                    NavigationLink {
                        SampleNewRealEstate( realEstate: $viewModel.newRealEstate, images: $viewModel.images, VideoURL: $viewModel.videoURL ,isAddNewEstateViewPresented: $isAddNewEstateViewPresented)
                    } label: {
                        Text("show sample before upload")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                            .frame(width: 300, height: 50)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                
                                .stroke(Color.blue , lineWidth: 2)
                                
                                )
                            .cornerRadius(12)
                }
                }

         
            }.padding(.horizontal , 0)
            .navigationTitle("New Real Estate")
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("cancel")
                    }

                }
            }
        }
    }
}

struct AddRealEstate_Previews: PreviewProvider {
    static var previews: some View {
        AddRealEstateView( isAddNewEstateViewPresented: .constant(true))
            .environmentObject(FirebaseRealEstateManger())
    }
}
