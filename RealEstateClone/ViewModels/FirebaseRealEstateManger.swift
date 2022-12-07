//
//  FirebaseRealEstateManger.swift
//  RealEstateClone
//
//  Created by Reenad gh on 02/02/1444 AH.


import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift
import FirebaseFirestore

class FirebaseRealEstateManger : NSObject, ObservableObject  {
    @Published  var realEstates : [RealEstate] = []
    @Published  var userRealEstates : [RealEstate] = []
    @Published  var bookMarkRealEstates : [RealEstate] = []

    let auth : Auth
    let firestore : Firestore
    let storage : Storage

    
    override init() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        super.init()
        
        self.fetchRealEstate()
        self.fetchUserRealEstates()
        self.fetchBookMarkRealEstates()


    }
    
    func fetchRealEstate() {
        print("fetching Real Estates ... ")
        firestore.collection("realEstate").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("DEBUG : \(error) ")
                return
            }
            
             guard let realEstates = querySnapshot?.documents.compactMap({ try? $0.data(as:RealEstate.self )})else {return }
            self.realEstates = realEstates.sorted{ $0.isAvailable && !$1.isAvailable}
        
        }
    }
    
    

    
    func fetchUserById(userId : String , completion : @escaping ((User)->()) ){

        firestore.collection("users").document(userId).getDocument { documentSnapshot, error in
            if let error = error {
                print("DEBUG : \(error) ")
                return
            }
            
            guard let user = try? documentSnapshot?.data(as : User.self) else {return }
            completion(user)
        }
    }
    
    
    func fetchUserRealEstates(){
        
        guard let userId = auth.currentUser?.uid else {
            return
        }
        firestore.collection("users").document(userId).collection("realEstate").addSnapshotListener{ quereySnapshot, error in
            if let error = error {
                print("DEBUG : \(error) ")
                return
            }
            guard let userRealEstates = quereySnapshot?.documents.compactMap({try? $0.data(as: RealEstate.self)}) else{return }
            
            self.userRealEstates = userRealEstates
            
        }
    }
    
    func fetchBookMarkRealEstates(){
        
        guard let userId = auth.currentUser?.uid else {
            return
        }
        firestore.collection("users").document(userId).collection("bookmarks").addSnapshotListener{ quereySnapshot, error in
            if let error = error {
                print("DEBUG : \(error) ")
                return
            }
            guard let bookmarkRealEstates = quereySnapshot?.documents.compactMap({try? $0.data(as: RealEstate.self)}) else{return }
            
            self.bookMarkRealEstates = bookmarkRealEstates
            
        }
    }


    
    func addRealEstate( realEstate : RealEstate , images : [UIImage] , videoURL :URL?,  completion : @escaping ((Bool)->())){
        
        var realEstate = realEstate

        uploadVideoToStorage(videourl: videoURL) { videoUrlString in
            realEstate.videoStringURL = videoUrlString
            
            self.uploadImagesToStorage(images: images) { imagesUrlString in
                realEstate.images = imagesUrlString
                do{
                    try self.firestore.collection("realEstate").document(realEstate.id).setData(from: realEstate)
                    
                    try self.firestore.collection("users").document(realEstate.ownerId).collection("realEstate").document(realEstate.id).setData(from : realEstate)

                }catch{
                    print("error to upload realeEstate")
                    print(error.localizedDescription)
                    completion(false)
                }
                
                completion(true)
            }
            
        
        }
        


       
    
    
}
    
    func bookMarkRealEstate(realEstate : RealEstate , userId : String){
        
        do{
        try  firestore.collection("users")
            .document(userId)
            .collection("bookmarks")
            .document(realEstate.id)
            .setData(from : realEstate)
        }
        catch {
            
            print("DEBUG : error in bookmark Real Estate !")
        }
    }
    
    func removeMarkRealEstate(realEstate : RealEstate ){
        guard let userId = auth.currentUser?.uid else {
            return
        }
        do{
        try  firestore.collection("users")
            .document(userId)
            .collection("bookmarks")
            .document(realEstate.id).delete()
            
        }
        catch {
            
            print("DEBUG : error in delete bookmark Real Estate !")
        }
    }
    
    func markRealEstate(realEstate : RealEstate){
      
        do{
        try  firestore.collection("users")
            .document(realEstate.ownerId)
            .collection("realEstate")
            .document(realEstate.id)
            .setData(from : realEstate)
   
        }
        catch {
            
            print("DEBUG : error in mark Real Estate !")
        }
        
        firestore.collection("realEstate").document(realEstate.id).delete()
    }
    
    func reAddRealEstate(realEstate : RealEstate){
      
        do{
        try  firestore.collection("users")
            .document(realEstate.ownerId)
            .collection("realEstate")
            .document(realEstate.id)
            .setData(from : realEstate)
            
            try self.firestore.collection("realEstate").document(realEstate.id).setData(from: realEstate)
   
        }
        catch {
            
            print("DEBUG : error in ReAdd Real Estate !")
        }
        
    }
    
    func uploadVideoToStorage (videourl : URL? , completion : @escaping ((String)->())){
        let videourl = videourl
        guard let userid = auth.currentUser?.uid else {return}
       
        if let  videourl = videourl {

        do {
            let videoData = try Data(contentsOf: videourl)
            let videoFileName = UUID().uuidString
            let refStorage = storage.reference(withPath: userid + "/" + videoFileName + "/" +  videourl.lastPathComponent)
            
            refStorage.putData(videoData, metadata: nil) { storageMetadata, error in
                if let error = error {
                    print("DEBUG : \(error) ")
                    return
                }
                
                refStorage.downloadURL { url, error in
                    if let error = error {
                        print("DEBUG : \(error) ")
                        return
                    }
                    guard let videoUrl =  url?.absoluteString else {return }
                    completion(videoUrl)
            }
        }
        
        }catch {
            print("DEBUG : error in video url ")

        }
            
        }else {
            completion("")
        }
    }
    
    
    
    
    func uploadImagesToStorage (images : [UIImage] , completion : @escaping (([String])->())){
        var imagesUrlString : [String] = []
        guard let userid = auth.currentUser?.uid else {return}
        
        for image in images {
            let imageId = UUID().uuidString
            guard let imageData = image.jpegData(compressionQuality: 0.4) else {return }
            let refStorage = storage.reference(withPath: userid + "/" + imageId)
            refStorage.putData(imageData) { storageMetadata, error in
                if let error = error {
                    print("DEBUG : \(error) ")
                    return
                }
                
                refStorage.downloadURL { url, error in
                    if let error = error {
                        print("DEBUG : \(error) ")
                        return
                    }
                    guard let imageURL =  url?.absoluteString else {return }
                    imagesUrlString.append(imageURL)
                    completion(imagesUrlString)
                  
                }
        }

        }
        
        
    }
    
}
