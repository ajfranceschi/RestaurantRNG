//
//  Restaurant.swift
//  RestaurantRNG
//
//  Created by Eric Crawford on 3/11/23.
//

import Foundation
import MapKit
import CoreLocation

struct Restaurant{
    var coordinate: CLLocationCoordinate2D
    var restaurantName: String?
    var rating: Int?
    var menu: [String?]?
    var priceSign: String?
    
}
