//
//  HelperMethods.swift
//  RestaurantRNG
//
//  Created by Antonio Franceschi on 3/21/23.
//

import Foundation

// YELP REQUEST

func getRestaurantsFromYelp(latitude: Double, longitude: Double) {
    guard (latitude >= -90 && latitude <= 90) else {
        print("latitude must be between -90 and 90")
        return
    }
    
    guard (longitude >= -180 && longitude <= 180) else {
        print("latitude must be between -180 and 180")
        return
    }
    
    
    let radius = 1600 // meters ~ 1 mile
    let category = "restaurants"
    let limit = 20
    
    let request = NSMutableURLRequest(url: NSURL(string: "\(YELP_API_BASE_URL)/businesses/search?latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&categories=\(category)&sort_by=distance&device_platform=ios&limit=\(limit)")! as URL,
                                             cachePolicy: .useProtocolCachePolicy,
                                             timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = YELP_HEADERS
    
    // Session
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
        if error != nil {
            print(error as Any)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse as Any)
        }
    }
    
    dataTask.resume()
}
