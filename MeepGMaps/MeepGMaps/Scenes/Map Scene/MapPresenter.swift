//
//  MapPresenter.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 08/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

protocol MapPresentationLogic {
    func presentSetupMap(response: Map.SetupMap.Response)
    func presentFetchedResources(response: Map.FetchResources.Response)
    func presenAlert(response: Map.PresentAlert.Response)
}

class MapPresenter: MapPresentationLogic {
    weak var viewController: MapDisplayLogic?
    
    private var colorToZone = [Int: UIColor]()
    
    /// PROTOCOL METHODS
    func presentSetupMap(response: Map.SetupMap.Response) {
        let initZoom: Float = 13.0
        let viewModel = Map.SetupMap.ViewModel(firstLocation: response.firstLocation, zoom: initZoom)
        self.viewController?.displaySetupMap(viewModel: viewModel)
    }
    
    func presentFetchedResources(response: Map.FetchResources.Response) {
        let fetchedResources = response.resources
        var markers = [GMSMarker]()
        fetchedResources.forEach({ (companyZonedId,resources) in
//            let colorValue = (CGFloat(companyZonedId % 255)) / 255.0
            let colorToZone = getColorTo(zoneId: companyZonedId)//UIColor(red: colorValue, green: 0.5, blue: 1.0, alpha: 1.0)//UIColor.random
            let currentMarker = GMSMarker.markerImage(with: colorToZone)
            for resource in resources {
                resource.marker.icon = currentMarker
                resource.marker.snippet = !(resource.resourceType.isEmpty) ? "\(resource.model) \nType: \(resource.resourceType) \nBattery level: \(resource.batteryLevel)" : resource.name
                markers.append(resource.marker)
            }
        })
        let viewModel = Map.FetchResources.ViewModel(markers: markers)
        self.viewController?.displayFetchedResources(viewModel: viewModel)
    }
    
    func presenAlert(response: Map.PresentAlert.Response) {
        let alert = UIAlertController(title: "Error", message: response.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        let viewModel = Map.PresentAlert.ViewModel(alert: alert)
        self.viewController?.displayAlert(viewModel: viewModel)
    }
    
    ///PRIVATE METHODS
    func getColorTo(zoneId: Int) -> UIColor {
        if let colorZone = colorToZone[zoneId]  {
            return colorZone
        } else {
            let randomColor = UIColor.random
            colorToZone[zoneId] = randomColor
            return randomColor
        }
    }
}
