//
//  ResourceMarker.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 09/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import UIKit
import GoogleMaps

class ResourceMarker: GMSMarker {
    let resource: Resource

    init(resource: Resource) {
    self.resource = resource
    super.init()
        
        position = CLLocationCoordinate2D(latitude: resource.latitude, longitude: resource.longitude)
    groundAnchor = CGPoint(x: 0.5, y: 1)
    appearAnimation = .pop

    //icon = UIImage(named: "pin")
  }
}
