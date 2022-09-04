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


    }
    
    func fetchRealEstate() {
        firestore.collection("realEstate").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("DEBUG : \(error) ")
                return
            }
            
             guard let realEstates = querySnapshot?.documents.compactMap({ try? $0.data(as:RealEstate.self )})else {return }
            self.realEstates = realEstates
        
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
