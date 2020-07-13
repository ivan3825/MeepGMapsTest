//
//  ResourceResponse.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 08/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import Foundation
import GoogleMaps

struct Resource {
    let id: String
    let name: String
    let resourceType: String
    let companyZoneId: Int
    let longitude: Double
    let latitude: Double
    let batteryLevel: Int
    let seats: Int
    let model: String
    let position: CLLocationCoordinate2D
    let marker: GMSMarker
    
    init(id: String,name: String,lon: Double,lat: Double,companyZoneId: Int, resourceType: String, batteryLevel: Int, seats: Int, model: String) {
        self.id = id
        self.name = name
        self.resourceType = resourceType
        self.companyZoneId = companyZoneId
        self.longitude = lon
        self.latitude = lat
        self.batteryLevel = batteryLevel
        self.seats = seats
        self.model = model
        self.position = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        self.marker = GMSMarker(position: self.position)
    }
}

struct ResourceResponse: Codable {
    let id: String?
    let name: String?
    let resourceType: String?
    let x: Double?
    let y: Double?
    let licencePlate: String?
    let range: Int?
    let batteryLevel: Int?
    let seats: Int?
    let model: String?
    let resourceImageId: String?
    let realTimeData: Bool?
    let scheduledArrival: Int?
    let locationType: Int?
    let companyZoneId: Int?
    let lat: Double?
    let lon: Double?
    let station: Bool?
    let availableResources: Int?
    let spacesAvailable: Int?
    let allowDropoff: Bool?
    let bikesAvailable: Int?
}
