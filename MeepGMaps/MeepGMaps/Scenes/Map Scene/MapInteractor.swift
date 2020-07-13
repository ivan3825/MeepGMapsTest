//
//  MapInteractor.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 08/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import Foundation
import GoogleMaps

protocol MapBusinessLogic {
    func setupMap(request: Map.SetupMap.Request)
    func fetchResources(request: Map.FetchResources.Request)
}

class MapInteractor: MapBusinessLogic {
    var presenter: MapPresentationLogic?
    
    private let lisboaLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 38.71667, longitude: -9.13333)
    
    /// PROTOCOL - IMPLEMENTATION - BUSINESS LOGIC
    func setupMap(request: Map.SetupMap.Request) {
        let response = Map.SetupMap.Response(firstLocation: lisboaLocation)
        self.presenter?.presentSetupMap(response: response)
    }
    
    func fetchResources(request: Map.FetchResources.Request) {
        let lowerLeftLatLon: String = "\(request.lowerLeftLatLon.latitude),\(request.lowerLeftLatLon.longitude)"
        let upperRightLatLon: String = "\(request.upperRightLatLon.latitude),\(request.upperRightLatLon.longitude)"
        
        MeepAPIWorker.shared.fetchResources(lowerLeftLatLon: lowerLeftLatLon, upperRightLatLon: upperRightLatLon, completion: { (resources, error) in
            if let _ = error {
                let response = Map.PresentAlert.Response(message: error!)
                self.presenter?.presenAlert(response: response)
                return
            }
            let resourcesWithMarkers = self.convert(resourceResponse: resources!)
            let response = Map.FetchResources.Response(resources: resourcesWithMarkers)
            self.presenter?.presentFetchedResources(response: response)
        })
    }
    
    /// PRIVATE METHODS
    private func convert(resourceResponse: [ResourceResponse]) -> [Int:[Resource]] {
        var companyZoneResourcesMap = [Int:[Resource]]()
        resourceResponse.forEach({ (resource) in
            if let id = resource.id,
                let name = resource.name,
                let lon = resource.x,
                let lat = resource.y,
                let companyZoneId = resource.companyZoneId {
                let resourceAux = Resource(id: id, name: name, lon: lon, lat: lat, companyZoneId: companyZoneId, resourceType: resource.resourceType ?? "",batteryLevel: resource.batteryLevel ?? -1,seats: resource.seats ?? -1, model: resource.model ?? "")
                if let _ = companyZoneResourcesMap[companyZoneId] {
                    companyZoneResourcesMap[companyZoneId]!.append(resourceAux)
                } else {
                    companyZoneResourcesMap[companyZoneId] = [Resource]()
                    companyZoneResourcesMap[companyZoneId]!.append(resourceAux)
                }
            }
        })
        return companyZoneResourcesMap
    }
}
