//
//  MapModels.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 08/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

enum Map {
    /// USE CASE - SETUP MAP
    enum SetupMap {
        struct Request {
            let mapView: GMSMapView
        }
        struct Response {
            let firstLocation: CLLocationCoordinate2D
        }
        struct ViewModel {
            let firstLocation: CLLocationCoordinate2D
            let zoom: Float
        }
    }
    /// USE CASE - FETCH RESOURCES
    enum FetchResources {
        struct Request {
            let lowerLeftLatLon: CLLocationCoordinate2D
            let upperRightLatLon: CLLocationCoordinate2D
        }
        struct Response {
            let resources: [Int:[Resource]]
        }
        struct ViewModel {
            let markers: [GMSMarker]
        }
    }
    
    /// USE CASE - PRESENT ALERT
    enum PresentAlert {
        struct Request {}
        struct Response {
            let message: String
        }
        struct ViewModel {
            let alert: UIAlertController
        }
    }
}
