//
//  ProfileView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 15/01/1444 AH.
//

import SwiftUI
import SDWebImageSwiftUI
struct ProfileView: View {
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @State var isloading : Bool = false
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        NavigationView{
    
            List{
    
                HStack {
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        WebImage(url: URL(string: firebaseUserManger.user.profileImageUrl))
                         .resizable()
                         .scaledToFill()
                         .frame(width: 120, height: 120, alignment: .center)
                         .clipShape(Circle())
                         .padding(8)
                         .overlay(Circle().stroke()
                            .foregroundColor(.gray)
                            )
                    }
                    .buttonStyle(.borderless)
             
                    Spacer()

                }.listRowBackground(Color.clear)
               
                Section {
                    
       
                    
                    
                    NavigationLink {

                    } label: {
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text(firebaseUserManger.user.email)
                        }.padding(7)

                    }
                    
                    
                    NavigationLink {
                        updatePhoneNumView(phoneNum: $firebaseUserManger.user.phoneNumber)

                    } label: {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text(firebaseUserManger.user.phoneNumber)
                        }.padding(7)
                    }
                    
                    
                    NavigationLink {
                        updateUserNameView(username: $firebaseUserManger.user.username)
                    } label: {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text(firebaseUserManger.user.username)
                        }.padding(7)
                    }
                    
        
                    
             

                } header: {
                    Text("account Info")
                } footer: {
                    Text("you can update your account info ")

                }
                
                Section {
                    NavigationLink {
                
                    } label: {
                        HStack {
                            Image(systemName: "building.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("My Real State")
                        }.padding(7)

                    }
                } header: {
                    Text("REAL ESTATE")

                } footer: {
                    Text("you can manage your properites at any time")
                }

                
                Section {
                    NavigationLink {
                
                    } label: {
                        HStack {
                            Image(systemName: "bookmark.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            Text("My Saved Real State")
                        }.padding(7)

                    }
                } header: {
                    Text("BOOKMARKS")

                } footer: {
                    Text("visit real Estate you have booked ")
                }
                
                
                Section {
                    VStack {
                        HStack {
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
                                            .frame(width: 100, height: 40)

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
                                            .frame(width: 130, height: 40)

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
                                        .frame(width: 200, height: 40)

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

                        ForEach ($firebaseUserManger.user.dayTimeAvailability , id: \.self) {$dayTime in
                            HStack{

                                    Text(dayTime.day.title)

                                DatePicker("", selection:
                   $dayTime.fromTime, displayedComponents: .hourAndMinute)
                                    Text("-")
                                        .padding(.leading , 12)
                                    DatePicker("", selection:
                                                $dayTime.toTime, displayedComponents: .hourAndMinute)
                                
                                    .frame(width: 100)

                                
                            }
                        }
                        
                        Divider()

                        Button {
                            firebaseUserManger.updateDayTimeAvailability { _ in
                                                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text("Update Schedule")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                Spacer()

                            }
                        .frame(height : 40)
                        .background(Color.blue.cornerRadius(12))
                        }.buttonStyle(.borderless)




                    }

                } header: {
                    Text("SAMBLE VIEW")
                } footer: {
                    Text("when people visit your properties, info will display as shown")
                }
                
                Section{
                    
                    Button {
                        isloading = true
                        firebaseUserManger.logOut { isSeccess in
                            if isSeccess {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    isloading = false
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Log out")
                                .font(.title3)
                                .foregroundColor(.red)
                            Spacer()
                        }
                        
                    }.buttonStyle(.borderless)

                }


            }
            .navigationBarTitle("Profile")
            .toolbar {
                ToolbarItem(placement:.navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }

                }
            }

        }
        .onAppear{
            firebaseUserManger.fetchUser()
        }
        .overlay(
            customProgressView().isHidden(!isloading, remove: !isloading)
        )
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(FirebaseUserManger())
    }
}
