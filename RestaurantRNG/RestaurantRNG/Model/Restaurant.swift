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

struct RestaurantResponse: Decodable {
    let businesses: [Restaurant]
    let total: Int
    let region: [String:[String:Double]]
}

struct Restaurant: Decodable {
    let name: String?
    let image_url: String?
    let is_closed: Bool?
    let url: String?
    let categories: [[Categories]]?
    let rating: Double?
    var coordinates: [Coordinates]
    let price: String?
    let distance: Double?
    let display_phone: String?
    let location: [Location]?
    
    struct Location: Decodable {
        let address1: String?
        let address2: String?
        let address3: String?
        let city: String?
        let zip_code: String?
        let country: String?
        let state: String?
        let display_address: [String]?
    }
    
    struct Coordinates: Decodable {
        var latitude: Double?
        var longitude: Double?
    }
    
    struct Categories: Decodable {
        let alias:String?
        let title:String?
    }
    
//    init(distance: Double, latitude: Double, longitude: Double, restaurantName: String, rating: Double?, priceSign: String?, location: [String : String], link: String?, imageURL: URL, isClosed: Bool, category: [String : String]) {
//        self.distance = distance
//        self.latitude = latitude
//        self.longitude = longitude
//        self.restaurantName = restaurantName
//        self.rating = rating
//        self.priceSign = priceSign
//        self.location = location
//        self.link = link
//        self.imageURL = imageURL
//        self.isClosed = isClosed
//        self.category = category
//    }
    
}

extension Restaurant {
    init(from service: Restaurant) {
        name = service.name
        image_url = service.image_url
        is_closed = service.is_closed
        url = service.url
        rating = service.rating
        price = service.price
        distance = service.distance
        display_phone = service.display_phone
        location = [Location]()
        coordinates = [Coordinates]()
        categories = [[Categories]]()
        
        for coordinate in service.coordinates {
            let item = Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
            coordinates.append(item)
        }
        
        // Location
        for l in service.location{
            let item = Location(address1: l.address1, address2: l.address2, address3: l.address3, city: l.city, zip_code: l.zip_code, country: l.country, state: l.state, display_address: l.display_address)
            location.append(item)
        }
        // Categories
        
    }
}
