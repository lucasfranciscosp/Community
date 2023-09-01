//
//  API.swift
//  Community
//
//  Created by Lucas Francisco on 17/08/23.
//

import Foundation

struct Address: Codable {
    let lat: Double
    let lon: Double
    let country: String  // Extracted from "display_name"
    let state: String
    let city: String
    let stateDistrict: String// Nested "address" dictionary
    var approved: Bool
}
