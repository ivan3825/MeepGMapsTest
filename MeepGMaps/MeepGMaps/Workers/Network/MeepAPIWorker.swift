//
//  MeepAPIWorker.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 08/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import Foundation
import Alamofire

class MeepAPIWorker {
    static var shared: MeepAPIWorker = MeepAPIWorker()
    
    func fetchResources(lowerLeftLatLon: String, upperRightLatLon: String, completion: @escaping (([ResourceResponse]?, String?) -> Void)) {
        let url = Constants.URL_API + "resources"
        let parameters: Parameters = ["lowerLeftLatLon" : lowerLeftLatLon,
                                      "upperRightLatLon" : upperRightLatLon]
        
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                do {
                    let resources = try JSONDecoder().decode([ResourceResponse].self, from: response.data!)
                    completion(resources, nil)
                } catch let error {
                    completion(nil, error.localizedDescription)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        })
    }
}
