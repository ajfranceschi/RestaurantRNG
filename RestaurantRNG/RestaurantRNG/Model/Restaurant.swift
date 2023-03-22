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
    //    let total: Int
    //    let region: [String:[String:Double]]
    
    
    struct Restaurant: Decodable {
        let name: String?
        let image_url: String?
        let is_closed: Bool?
        let url: String?
        var categories: [[Categories]]
        let rating: Double?
        var coordinates: [Coordinates]
        let price: String?
        let distance: Double?
        let display_phone: String?
        var location: [Location]
        
        struct Location: Decodable {
            let address1: String?
            let address2: String?
            let address3: String?
            let city: String?
            let zip_code: String?
            let country: String?
            let state: String?
            let display_address: [String]?
            
            init(addr1: String?, addr2: String?, addr3: String?, pCity: String?, zipCode: String?, pCountry: String?, pState: String?, displayAddress: [String]?) {
                self.address1 = addr1
                self.address2 = addr2
                self.address3 = addr3
                self.city = pCity
                self.zip_code = zipCode
                self.country = pCountry
                self.state = pState
                self.display_address = displayAddress
            }
        }
        
        struct Coordinates: Decodable {
            var latitude: Double
            var longitude: Double
            
            init(latitude: Double, longitude: Double) {
                self.latitude = latitude
                self.longitude = longitude
            }
        }
        
        struct Categories: Decodable {
            var alias:String?
            var title:String?
            
            init(alias: String?, title: String?) {
                self.alias = alias
                self.title = title
            }
        }
        
    }
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
            coordinates.append(coordinate)
            //            let item = Coordinates(latitude: coordinate.latitude, longitude: coordinate.longitude)
//            coordinates.append(item)
        }
        
        // Location
        for loc in service.location {
            location.append(loc)
//            let loc = Location(addr1: loc.address1, addr2: loc.address2, addr3: loc.address3, pCity: loc.city, zipCode: loc.zip_code, pCountry: loc.country, pState: loc.state, displayAddress: loc.display_address)
//
//            location.append(loc)
        }
        
        // Categories
        for category in service.categories {
            categories.append(category)
        }
    }
}
