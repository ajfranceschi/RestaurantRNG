//
//  Restaurant.swift
//  RestaurantRNG
//
//  Created by Eric Crawford on 3/11/23.
//

import Foundation
import MapKit
import CoreLocation
import Nuke

struct Restaurant {
    let name: String
    let image_url: URL?
    let is_closed: Bool
    let url: URL
    var category: String
    let rating: Double
    let latitude: Double
    let longitude: Double
    let price: String
    let distance: Double
    let display_phone: String?
    let streetAddress1: String
    let streetAddress2: String
    let zipCode: String
    let city : String
    let country: String
    let state: String
    
    func toString() {
        print(name)
        print(streetAddress1)
        print()
    }
    
}
