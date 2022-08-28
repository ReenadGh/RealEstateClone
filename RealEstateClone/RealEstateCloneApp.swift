//
//  RealEstateCloneApp.swift
//  RealEstateClone
//
//  Created by Reenad gh on 10/01/1444 AH.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    
}
@main
struct RealEstateCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    //StateObject : when you need to create a reference type inside one of your views and make sure the object stays alive for use in that view and others you share it with.
    @StateObject private var firebaseUserManger = FirebaseUserManger()
    var body: some Scene {
        WindowGroup {
            HomeView()
            //Rather than creating some data in view A, then passing it to view B, then view C, then view D before finally using it, you can create it in view A and put it into the environment so that views B, C, and D will automatically have access to it.
            
//
            
                .environmentObject(firebaseUserManger)
        }
    }
}
