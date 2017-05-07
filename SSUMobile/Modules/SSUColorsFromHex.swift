//
//  UIColorFromHex.swift
//  tableviewExample
//
//  Created by scullen on 4/23/17.
//  Copyright © 2017 Sonoma State University Department of Computer Science. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
    let blue = CGFloat(rgbValue & 0xFF)/256.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}
