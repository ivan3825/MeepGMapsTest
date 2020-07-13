//
//  MapViewController.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 08/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapDisplayLogic: NSObjectProtocol {
    func displaySetupMap(viewModel: Map.SetupMap.ViewModel)
    func displayFetchedResources(viewModel: Map.FetchResources.ViewModel)
    func displayAlert(viewModel: Map.PresentAlert.ViewModel)
}

class MapViewController: UIViewController, MapDisplayLogic {
    @IBOutlet weak var mapView: GMSMapView!
    
    var interactor: MapBusinessLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupModule()
        self.setupMap()
    }
    
    private func setupModule() {
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        /// Router no necessary
    }
    
    private func setupMap() {
        let request = Map.SetupMap.Request(mapView: self.mapView)
        self.interactor?.setupMap(request: request)
    }
    
    private func updateResourcesOnCurrentLocation() {
        let projection = self.mapView.projection.visibleRegion()
        let topRightCorner: CLLocationCoordinate2D = projection.farRight
        let bottomLeftCorner: CLLocationCoordinate2D = projection.nearLeft
        
        let request = Map.FetchResources.Request(lowerLeftLatLon: bottomLeftCorner, upperRightLatLon: topRightCorner)
        self.interactor?.fetchResources(request: request)
    }

    /// PROTOCOL - IMPLEMENTATION - DISPLAY LOGIC
    func displaySetupMap(viewModel: Map.SetupMap.ViewModel) {
        self.mapView.animate(toLocation: viewModel.firstLocation)
        self.mapView.animate(toZoom: viewModel.zoom)
        self.mapView.delegate = self
    }
    
    func displayFetchedResources(viewModel: Map.FetchResources.ViewModel) {
        DispatchQueue.main.async {
            self.mapView.clear()
            let markers = viewModel.markers
            for marker in markers {
                marker.map = self.mapView
            }
            
        }
    }
    
    func displayAlert(viewModel: Map.PresentAlert.ViewModel) {
        present(viewModel.alert, animated: true, completion: nil)
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.updateResourcesOnCurrentLocation()
    }
}

