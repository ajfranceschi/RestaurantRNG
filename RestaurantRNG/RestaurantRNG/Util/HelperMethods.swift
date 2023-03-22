//
//  HelperMethods.swift
//  RestaurantRNG
//
//  Created by Antonio Franceschi on 3/21/23.
//

import Foundation

// YELP REQUEST

func getRestaurantsFromYelp(latitude: Double, longitude: Double) {
    var restaurants = [Restaurant]()
    
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
    session.dataTask(with: request as URLRequest) { data, response, error in
        if error != nil {
            print(error as Any)
        } else {
            guard let jsonData = data else {
                print("Data is nil")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode([RestaurantResponse].self, from: jsonData)
                
                let businesses = jsonResponse[0].map {Restaurant(from: $0)} //root of business
                let restaurants = businesses.map {Restaurant(from: $0)}
                    
                }
                
            } catch let error {
                print("Error Parsing JSON: \(error.localizedDescription)")
            }
        }
    }.resume()
    
}
