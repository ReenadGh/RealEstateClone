//
//  AuthView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 10/01/1444 AH.
//
import SwiftUI
struct AuthView: View {
    
    @State var isNewUser : Bool = false
    @State var mail : String = ""
    @State var errorMessage : String = ""
    @State var password : String = ""
    @State var username : String = ""
    @State private var showingImagePicker = false
    @State var userImg : UIImage? 
    @State var inputImg : UIImage?
    @State var isloading : Bool = false
    @State var isShowingHomeView : Bool = false

    
    @EnvironmentObject var firebaseUserManger : FirebaseUserManger
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var locationManger :  LocationManager = LocationManager()
    
    func loadImage() {
        guard let inputImage = inputImg else { return }
        userImg = inputImage
    }
    
    
    var body: some View {
        

        NavigationView {
            
                ScrollView {
                    HStack{
                    Text("Welocme to RealEstateClone")
                            .font(.system(size: 40 , weight : .semibold))
                        Spacer()
                    }//HSTACK
                    .padding(.horizontal , 20)

                    Picker(selection:$isNewUser){
                        Text("Log in")
                            .tag(false)
                        Text("Sign up")
                            .tag(true)
                    }label : {
                    }.pickerStyle(.segmented)
                     .padding()
                     .onChange(of: isNewUser) { _ in
                         errorMessage = ""
                     }
                    
                    VStack (spacing : 20){
                
                        
                        if  userImg == nil {
                            //userImg =
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 90, height: 90)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showingImagePicker = true
                            }
                            .onChange(of: inputImg){_ in
                                loadImage()
                            }
                            .sheet(isPresented: $showingImagePicker) {
                                ImagePicker(image: $inputImg)
                                
                            }
                            .isHidden(!isNewUser, remove:!isNewUser)

                        }else{
                            Image(uiImage: userImg!)
                                .resizable()
                                .frame(width: 130, height: 130)
                            .clipShape(Circle())
                            .shadow(color: .gray.opacity(0.8), radius:5, x: 5, y: 5)
                            .onTapGesture {
                                showingImagePicker = true
                            }
                            .onChange(of: inputImg){_ in
                                loadImage()
                            }
                            .sheet(isPresented: $showingImagePicker) {
                                ImagePicker(image: $inputImg)
                            }
                            .isHidden(!isNewUser, remove:!isNewUser)
                        }
                    
                        
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)

                        HStack (spacing: 10) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            TextField("Email", text: $mail)
                        }
                        .flipsForRightToLeftLayoutDirection(true)
                        .modifier(textFieldModifire())

                        
                        HStack (spacing: 10) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            TextField("user name", text: $username)
                        }
                        
                        .isHidden(!isNewUser, remove:!isNewUser)
                        .modifier(textFieldModifire())

                        HStack (spacing: 10) {
                            Image(systemName: "key.fill")
                                .foregroundColor(.gray)
                                .imageScale(.large)
                            SecureField("password", text: $password)
                        }
                        .modifier(textFieldModifire())
                        
                        Button {
                            
                            // MARK: - Register Function Call
                            guard let userLocation = locationManger.userLocation?.coordinate else{return}
                            
                            isloading.toggle()
                            if isNewUser{
                                firebaseUserManger.createNewUser(mail: mail, password: password, userName: username, location: userLocation, userPhoto: userImg) { isSuccess , error in
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                        if isSuccess {
                                            isloading.toggle()
                                            isShowingHomeView = true
                                        }else{
                                            isloading.toggle()
                                            errorMessage = error
                                        }
                                        }
                                    }
                                
                            }else{
                                firebaseUserManger.logInToAccount(mail: mail, password: password) { isSuccess, error in
                                    if isSuccess {
                                        isloading.toggle()
                                        isShowingHomeView = true
                                    }else{
                                        isloading.toggle()
                                        errorMessage = error
                                    }
                                }
                                
                            }

                  
                       
                        } label: {
                            Text(isNewUser ? "Sign Up" : "Log In")
                                .foregroundColor(.white)
                                .frame(maxWidth:.infinity)
                                .frame(height : 30)
                                .padding()
                                .background(
                                    Color.blue)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal , 20)


                    }
                    

              
                    
                    
                        
              
                    
                    
                }//SCROLL
                
                .animation(.easeOut, value: isNewUser)
                .navigationBarTitle("")
                .toolbar{
                    
                    
                    ToolbarItem(placement:.navigationBarLeading, content: {
                       
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Text("Dismiss")
                            
                        })
                        
                    })
            
            }

        }//NAV
        .overlay(
            customProgressView().isHidden(!isloading, remove: !isloading)
        )
        .fullScreenCover(isPresented: $isShowingHomeView) {
            HomeView()
        }
        
    }
        
        
}



struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        
        AuthView()
            .environmentObject(FirebaseUserManger())
        
    }
}
