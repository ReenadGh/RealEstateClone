//
//  Model.swift
//  RealEstateClone
//
//  Created by Tariq Almazyad on 7/17/22.
//

import Foundation
import CoreLocation
import SwiftUI
import MapKit
import LoremSwiftum

let realEstateExamble : RealEstate = .init(id: "132", images: ["Image 1","Image 3","Image 2","Image 4","Image 5"], description: Lorem.tweet, beds: Int.random(in: 1...4), baths: Int.random(in: 1...4), livingRooms: Int.random(in: 1...4), space: Int.random(in: 1...4), ovens: Int.random(in: 1...4), fridges: Int.random(in: 1...4), microwaves: Int.random(in: 1...4), airConditions: Int.random(in: 1...4), isSmart: true, hasWiFi: false, hasPool: false, hasElevator: true, hasGym: true, age: Int.random(in: 1...4), location: City.arrass.coordinate, saleCategory: SaleCategory.rent, city: City.arrass, type: RealEstateType.apartment, offer: OfferType.daily, isAvailable: true , price: 1000 , videoStringURL: "https://bit.ly/swswift")

enum SaleCategory: String, CaseIterable, Codable{
    case sale
    case rent
    case investment
    
    var title: String {
        switch self {
        case .sale:       return "Sale"
        case .rent:       return "Rent"
        case .investment: return "Investment"
        }
    }
    
    var saleColor: Color{
        switch self {
        case .sale:       return . green
        case .rent:       return .indigo
        case .investment: return .cyan
        }
    }
    
    var markedTitle: String{
        switch self {
        case .sale:       return "SOLD"
        case .rent:       return "RENTED"
        case .investment: return "Invseted"
        }
    }
    
    var imageName: String {
        switch self{
        case .sale:       return "dollarsign.circle.fill"
        case .rent:       return "dollarsign.square"
        case .investment: return "chart.xyaxis.line"
        }
    }
}

enum RealEstateType: String, CaseIterable , Codable {
    case apartment
    case house
    case townHouse
    case farm
    case land
    case building
    case office
    case room
    case penthouse
    case floor
    case camp
    case chalet
    
    var title: String {
        switch self{
        case .apartment:  return "Apartment"
        case .house:      return "House"
        case .townHouse:  return "Town House"
        case .farm:       return "Farm"
        case .land:       return "Land"
        case .building:   return "Building"
        case .office:     return "Office"
        case .room:       return "Room"
        case .penthouse:  return "Penthouse"
        case .floor:      return "Floor"
        case .camp:       return "Camp"
        case .chalet:     return "Chalet"
            
        }
    }
    
    var imageName: String {
        switch self{
        case .apartment:  return "bed.double.circle"
        case .house:      return "house.fill"
        case .townHouse:  return "building.2.fill"
        case .farm:       return "laurel.trailing"
        case .land:       return "camera.macro"
        case .building:   return "building.fill"
        case .office:     return "briefcase.fill"
        case .room:       return "sofa.fill"
        case .penthouse:  return "building.2.crop.circle.fill"
        case .floor:      return "door.garage.double.bay.closed"
        case .camp:       return "tent.fill"
        case .chalet:     return "pedestrian.gate.closed"
            
        }
    }
}

enum OfferType: String, CaseIterable, Codable {
    case daily
    case monthly
    case yearly
    
    var title: String{
        switch self {
        case .daily:   return "Daily"
        case .monthly: return "Monthly"
        case .yearly:  return "Yearly"
        }
    }
}

enum City: String, CaseIterable, Codable {
    case arrass
    case qassim
    case riyadh
    case almadinah
    case meccah
    case tabuk
//    case najran
//    case jazan
//    case hail
//    case asir
//    case jawf
//    case bahah
    
    var title: String {
        switch self {
        case .arrass:    return "Alrass"
        case .qassim:    return "Alqassim"
        case .riyadh:    return "Riyadh"
        case .almadinah: return "Almadinah"
        case .meccah:    return "Meccah"
        case .tabuk:     return "Tabuk"
//        case .najran:    return "Najran"
//        case .jazan:     return "Jazan"
//        case .hail:      return "Hail"
//        case .asir:      return "Asir"
//        case .jawf:      return "Jawf"
//        case .bahah:     return "Bahah"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .arrass:     return .init(latitude: 25.869636, longitude: 43.498475)
        case .qassim:     return .init(latitude: 26.100814, longitude: 43.860099)
        case .riyadh:     return .init(latitude: 24.7136, longitude: 46.6753)
        case .almadinah:  return .init(latitude: 24.467857, longitude: 39.614242)
        case .meccah:     return .init(latitude: 21.409623, longitude: 39.816230)
        case .tabuk:      return .init(latitude: 28.400551, longitude: 36.557152)
//        case .najran:     return .init(latitude: 0.0, longitude: 0.0)
//        case .jazan:      return .init(latitude: 0.0, longitude: 0.0)
//        case .hail:       return .init(latitude: 0.0, longitude: 0.0)
//        case .asir:       return .init(latitude: 0.0, longitude: 0.0)
//        case .jawf:       return .init(latitude: 0.0, longitude: 0.0)
//        case .bahah:      return .init(latitude: 0.0, longitude: 0.0)
        }
    }
    
    var extraZoomLevel: MKCoordinateSpan {
        switch self {
        case .arrass:     return .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
        case .qassim:     return .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        case .riyadh:     return .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        case .almadinah:  return .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        case .meccah:     return .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        case .tabuk:      return .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        case .najran:     return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .jazan:      return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .hail:       return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .asir:       return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .jawf:       return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .bahah:      return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        }
    }
    
    var zoomLevel: MKCoordinateSpan {
        switch self {
        case .arrass:     return .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
        case .qassim:     return .init(latitudeDelta: 1.0, longitudeDelta: 1.0)
        case .riyadh:     return .init(latitudeDelta: 0.3, longitudeDelta: 0.3)
        case .almadinah:  return .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
        case .meccah:     return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        case .tabuk:      return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .najran:     return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .jazan:      return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .hail:       return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .asir:       return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .jawf:       return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        case .bahah:      return .init(latitudeDelta: 0.1, longitudeDelta: 0.1)
        }
    }
}

struct RealEstate: Codable, Equatable , Identifiable {
    static func == (lhs: RealEstate, rhs: RealEstate) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id = UUID().uuidString
    var images: [String] = []
    var description: String = ""
    var beds: Int = 0
    var baths: Int = 0
    var livingRooms: Int = 0
    var space: Int = 0
    var ovens: Int = 0
    var fridges: Int = 0
    var microwaves: Int = 0
    var airConditions: Int = 0
    
    var isSmart:     Bool = false
    var hasWiFi:     Bool = false
    var hasPool:     Bool = false
    var hasElevator: Bool = false
    var hasGym:      Bool = false
    
    var age: Int = 0
    var location: CLLocationCoordinate2D = .init(latitude: 0.0, longitude: 0.0)
        var saleCategory          : SaleCategory = .rent
    var city                  : City = .arrass
    var type                  : RealEstateType = .apartment
    var offer                 : OfferType      = .yearly
    var isAvailable           : Bool = true
    var price                 : Int = 0
    var videoStringURL        : String = ""
    
}




struct User: Codable, Identifiable {
    var id                  : String              = ""
    var profileImageUrl     : String              = ""
    var favoriteRealEstate  : [String]            = []
    var realEstates         : [String]            = []
    var phoneNumber         : String              = ""
    var email               : String              = ""
    var username            : String              = ""
    var isVerified          : Bool                = false
    var dayTimeAvailability : [DayTimeSelection]  = []
    var location            : CLLocationCoordinate2D = .init(latitude: 0.0, longitude: 0.0)
}

struct DayTimeSelection: Hashable, Codable {
    var day: AvailabilityDay
    var fromTime: Date
    var toTime: Date
}

enum AvailabilityDay: String , CaseIterable, Codable, Identifiable {
    
    var id: String { rawValue }
    
    case saturday
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    
    
    var title: String {
        switch self {
        case .saturday:  return "Saturday"
        case .sunday:    return "Sunday"
        case .monday:    return "Monday"
        case .tuesday:   return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday:  return "Thursday"
        case .friday:    return "Friday"
        }
    }
    
}


enum MediaType : String , CaseIterable {
    case  photo
    case  video
    
    var title : String {
        switch self {
        case .photo:
            return "Photos"
        case .video:
            return "Videos"
     
        }
        
    }
}
