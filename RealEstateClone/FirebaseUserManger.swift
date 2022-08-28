//
//  FirebaseUserManger.swift
//  RealEstateClone
//
//  Created by Reenad gh on 14/01/1444 AH.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import CoreLocation

//ObservableObject :  used inside views, so that when important changes happen the view will reload
class FirebaseUserManger : NSObject, ObservableObject {
    @Published var user : User = .init()
    let auth : Auth
    let firestore : Firestore
    let storage : Storage
    
    
    override init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        
        //For safety reasons, Swift always makes you call super.init() from child classes – just in case the parent class does some important work when it’s created.
        super.init()
        self.fetchUser()
    }
    
    
    
    func fetchUser(){
        guard let userId = auth.currentUser?.uid else {return}
        firestore.collection("users").document(userId).getDocument { documentSnapshot, error in
            if let error = error {
                print("DEBUG : log in fetching user  : \(error.localizedDescription)")
                return
            }
            
            guard let user = try? documentSnapshot?.data(as: User.self) else {return}
            self.user = user
        }
        
    }
    
    func isUserLogin() -> Bool{
        fetchUser()
        return user.id == ""
    }
    
    
    func logInToAccount(mail : String , password : String ,  completion: @escaping((Bool , String ) -> ())){
        
        auth.signIn(withEmail: mail, password: password) { _, error in
            if let error = error {
                completion(false , "\(error.localizedDescription)")
                print("DEBUG : log in user error : \(error.localizedDescription)")
                return
            }
            completion(true , "")
            
        }
 }
    
    func logOut(completion : @escaping((Bool)->())){
        do{
            try auth.signOut()
            user = .init()
            completion(true)
        }catch{
            print("DEBUG : error signing out")
            completion(false)
        }
        
    }
    func updateUserName(newUserName : String , completion : @escaping((Bool ) -> ())){
        
        self.user.username = newUserName
        try? firestore.collection("users").document(self.user.id).setData(from: self.user, merge: true){error in
            
            if let error = error {
                completion(false)
                print("DEBUG : updateUserName : \(error.localizedDescription)")
                return
            }
            completion(true)

        }
    }
    
    func updatePhoneNum(newUserName : String , completion : @escaping((Bool ) -> ())){
        
        self.user.phoneNumber = newUserName
        try? firestore.collection("users").document(self.user.id).setData(from: self.user, merge: true){error in
            
            if let error = error {
                completion(false)
                print("DEBUG : updatePhoneNum : \(error.localizedDescription)")
                return
            }
            completion(true)

        }
    }
    
    func updateDayTimeAvailability( completion : @escaping((Bool ) -> ())){
        
        try? firestore.collection("users").document(self.user.id).setData(from: self.user, merge: true){error in
            
            if let error = error {
                completion(false)
                print("DEBUG : updateDayTimeAvailability : \(error.localizedDescription)")
                return
            }
            completion(true)

        }
    }
    
    
    
    func createNewUser (mail : String , password : String , userName : String  ,location : CLLocationCoordinate2D, userPhoto : UIImage?, completion: @escaping((Bool , String ) -> ())){
 


        auth.createUser(withEmail: mail, password: password) { result , error in
            print("Creating user ..." )

            if let error = error {
                completion(false , "\(error.localizedDescription)")
                print("DEBUG : create user error : \(error.localizedDescription)")
                return
            }
            
            guard let userId = result?.user.uid else {
                print("DEBUG : no user id to crate ")
                return
            }
      
            self.uploadUserPhotoToStorage(userId: userId, photo:userPhoto) { photoUrlString in
     

                let user = User(id: userId, profileImageUrl: photoUrlString, favoriteRealEstate: [], realEstates: [], phoneNumber: "", email: mail, username: userName, isVerified: false, dayTimeAvailability: [
                    .init(day: .friday, fromTime: Date(), toTime: Date()),
                    .init(day: .saturday, fromTime: Date(), toTime: Date()),
                    .init(day: .sunday, fromTime: Date(), toTime: Date()),
                    .init(day: .monday, fromTime: Date(), toTime: Date()),
                    .init(day: .tuesday, fromTime: Date(), toTime: Date()),
                    .init(day: .wednesday, fromTime: Date(), toTime: Date()),
                    .init(day: .thursday, fromTime: Date(), toTime: Date())
                ], location: location)
                
                //add it to database
                do{
               try self.firestore.collection("users").document(userId).setData(from: user)
                }catch{
                    print("photo error")

                    print(error.localizedDescription)
                }
                completion(true , "")
            }
            
        
        }
    }
    
    
    
    func uploadUserPhotoToStorage (userId : String , photo : UIImage? , completion : @escaping((String)->())){
        
        let profileImgId = UUID().uuidString
         
        if photo != nil {
            guard let imgData = photo?.jpegData(compressionQuality: 0.5)else{return}
            let ref = storage.reference(withPath: userId + "/" + profileImgId)
            ref.putData(imgData , metadata: nil) { storageMetadata, error in
                if let error = error {
                    print("DEBUG : upload userphoto error : \(error.localizedDescription)")
                    return
                }
                
                
                ref.downloadURL { url, error in
                    if let error = error {
                        print("DEBUG : upload userphoto error : \(error.localizedDescription)")
                        return
                    }
                    guard let profilePhotoUrl = url?.absoluteString else {return }
                    completion(profilePhotoUrl)
                }
            }
        }
        completion("")

        
    }
}
