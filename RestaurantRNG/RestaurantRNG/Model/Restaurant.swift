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
struct Restaurant{
    let distance: Double
    let latitude: Double
    let longitude: Double
    let restaurantName: String
    let rating: Double?
    let priceSign: String?
    var location: [String:String]
    let link: String?
    let imageURL: URL
    let isClosed: Bool
    let category: [String:String]
    
    init(distance: Double, latitude: Double, longitude: Double, restaurantName: String, rating: Double?, priceSign: String?, location: [String : String], link: String?, imageURL: URL, isClosed: Bool, category: [String : String]) {
        self.distance = distance
        self.latitude = latitude
        self.longitude = longitude
        self.restaurantName = restaurantName
        self.rating = rating
        self.priceSign = priceSign
        self.location = location
        self.link = link
        self.imageURL = imageURL
        self.isClosed = isClosed
        self.category = category
    }
    
}
