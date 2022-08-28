//
//  mapKitView.swift
//  RealEstateClone
//
//  Created by Reenad gh on 26/01/1444 AH.
//

import Foundation
import UIKit
import SwiftUI
import MapKit
 

struct MapUIKitView : UIViewRepresentable {
    @Binding var realEstate : RealEstate
    let mapView = MKMapView()
    func makeUIView(context: Context) -> some MKMapView {
        mapView.delegate = context.coordinator
        mapView.setRegion(.init(center: realEstate.city.coordinate, span: realEstate.city.extraZoomLevel ), animated: true)

        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    
    class Coordinator : NSObject , MKMapViewDelegate , UIGestureRecognizerDelegate {
        
        let parent : MapUIKitView
        var gRecognizer = UILongPressGestureRecognizer()
        
        init(_ parent : MapUIKitView ){
            self.parent = parent
            super.init()
        }
        
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            self.parent.realEstate.location = mapView.centerCoordinate
        }
    }
}
