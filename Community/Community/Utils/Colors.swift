//
//  Colors.swift
//  Community
//
//  Created by Caio Melloni dos Santos on 18/08/23.
//

import Foundation

import UIKit
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat = 1.0) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opacity)
   }

   convenience init(hex: Int, opacity: CGFloat = 1.0) {
       self.init(
           red: (hex >> 16) & 0xFF,
           green: (hex >> 8) & 0xFF,
           blue: hex & 0xFF,
           opacity: opacity
       )
   }
}

class PaleteColor {
    static var accentLight: UIColor = UIColor(hex: 0x3E6B2D)
    static var accentDark: UIColor = UIColor(hex: 0x55943E)
    static var color1: UIColor = UIColor(hex: 0xF6EEE9)
    static var color2: UIColor = UIColor(hex: 0xEAD8D4)
    static var color3: UIColor = UIColor(hex: 0x928684)
    static var color4: UIColor = UIColor(hex: 0x221E1E)
    static var primary1: UIColor = UIColor(hex: 0x546F31)
    static var primary2: UIColor = UIColor(hex: 0x738B39)
    static var primary3: UIColor = UIColor(hex: 0x9CB26C)
    static var secondary1: UIColor = UIColor(hex: 0xF0754F)
    static var secondary2: UIColor = UIColor(hex: 0x913E24)
    static var secondary3: UIColor = UIColor(hex: 0xCE5239)
}
