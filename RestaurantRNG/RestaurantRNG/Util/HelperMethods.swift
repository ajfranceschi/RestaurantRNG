////
////  HelperMethods.swift
////  RestaurantRNG
////
////  Created by Antonio Franceschi on 3/21/23.
////
//
//import Foundation
//import YelpAPI
//
//// YELP REQUEST
//
//func getRestaurantsFromYelp(latitude: Double, longitude: Double){
//    guard (latitude >= -90 && latitude <= 90) else {
//        print("latitude must be between -90 and 90")
//        return
//    }
//    
//    guard (longitude >= -180 && longitude <= 180) else {
//        print("latitude must be between -180 and 180")
//        return
//    }
//    
//    // MARK: Yelp API Test
//    let yelpClient = YLPClient(apiKey: YELP_API_KEY)
//    let yelpCoordinate = YLPCoordinate(latitude: latitude, longitude: longitude)
//    let yelpQuery = YLPQuery(coordinate: yelpCoordinate)
//    yelpQuery.categoryFilter = ["restaurants"]
//    yelpQuery.radiusFilter = 1600
//    yelpQuery.limit = 20
//
//    
//    yelpClient.search(with: yelpQuery) { search, error in
//        if let error = error {
//            print("Could not complete search. Error: \(error)")
//        } else {
//            if let search = search {
//                print(search.businesses.count)
//                for business in search.businesses {
//                    var stAddress2 = ""
//                    if business.location.address.count > 1 {
//                        stAddress2 = business.location.address[1]
//                    }
//                    MapViewController.restaurants.append(Restaurant(
//                        name: business.name,
//                        image_url: business.imageURL,
//                        is_closed: business.isClosed,
//                        url: business.url, category: business.categories[0].name,
//                        rating: business.rating,
//                        latitude: business.location.coordinate!.latitude,
//                        longitude: business.location.coordinate!.longitude,
//                        price: business.price,
//                        distance: business.distance,
//                        display_phone: business.phone,
//                        streetAddress1: business.location.address[0],
//                        streetAddress2: stAddress2,
//                        zipCode: business.location.postalCode,
//                        city: business.location.city,
//                        country: business.location.countryCode,
//                        state: business.location.stateCode))
//                }
//            }
//        }
//        for restaurant in MapViewController.restaurants {
//            restaurant.toString()
//        }
//    }
//    
//    
//}
