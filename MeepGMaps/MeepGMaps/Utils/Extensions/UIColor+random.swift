//
//  UIColor+random.swift
//  MeepGMaps
//
//  Created by Iván Ibáñez Torres on 10/07/2020.
//  Copyright © 2020 IIT Developer. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }

}
