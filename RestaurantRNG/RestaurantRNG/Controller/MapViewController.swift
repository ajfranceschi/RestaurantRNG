//
//  ViewController.swift
//  RestaurantRNG
//
//  Created by Antonio Franceschi on 3/10/23.
//

import UIKit
import MapKit
import YelpAPI

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var prefsButton: UIBarButtonItem!
    @IBOutlet weak var centerOnUserLocationButton: UIButton!
    
    private let locationManager = CLLocationManager()
    // set current location to FIU campus until updated by device location
    private var currentLocation : CLLocation? //= CLLocation(latitude: 25.7562, longitude: -80.3755)
    
    // store data from the settings VC
    var distance = 5.0
    var rating = 0.0
    var price = 5
        
    var restaurants = [Restaurant]() {
        didSet {
            DispatchQueue.main.async {
                self.updateMapView(self.distance, self.distance)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//        if let helpVC = storyboard?.instantiateViewController(withIdentifier: "HelpVC") {
//            // helpVC.modalPresentationStyle = .currentContext
//            // show(helpVC, sender: self)
//            present(helpVC, animated: true)
//        }
        // }
        
        locationManager.requestWhenInUseAuthorization()
        
        if locationManager.authorizationStatus == .denied {
            showAlert(title: "Location Error", message: "Application denied user location data. Please update Settings.", type: "locationDenied")
        } else {
            
            // set CLLocationManager delegate to self
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // one-time request for location, must be called after setting delegate
            locationManager.requestLocation()
        }
        
        // set mapView delegate to self
        mapView.delegate = self
        
        // Remove default POIs
        let mapConfiguration = MKStandardMapConfiguration()
        mapConfiguration.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
//        mapView.isUserInteractionEnabled = false // disable interaction with map
        mapView.preferredConfiguration = mapConfiguration
  
    }
    
    private func updateMapView(_ latitudeDelta: Double = 0.05, _ longitudeDelta: Double = 0.05) {
        
        // set mapView's region based on coordinates
        // span represents "zoom level", where a small value is more zoomed in
        // this should eventually be adjusted based on search radius selected by user
        if let currentLocation = currentLocation {
            let region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: latitudeDelta/50, longitudeDelta: longitudeDelta/25)) // each CLLocationDegree used in MKCoordinateRegion represents 69 miles
            mapView.setRegion(region, animated: true)
        }
        // remove anotations
        self.mapView.annotations.forEach {
          if !($0 is MKUserLocation) {
            self.mapView.removeAnnotation($0)
          }
        }
        
        // "for each" loop that effectively adds a pin/annotation for each restaurant in array
        if restaurants.count != 0 {
            restaurants.forEach {
                if !$0.is_closed {
                    let annotation = MKPointAnnotation()
                    annotation.title = $0.price
                    annotation.coordinate = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
                    mapView.addAnnotation(annotation)
                }
            }
            
            chooseButton.isEnabled = true
        }
    }
    
    private func updateRestaurants() {
        
        // MARK: Declare a constant named YELP_API_KEY in /RestaurantRNG/Env/EnvVars.swift (must create structure for your project)

//        if NetworkMonitor.shared.isConnected {
        if let currentLocation = currentLocation {
            let latitude = currentLocation.coordinate.latitude
            let longitude = currentLocation.coordinate.longitude
            getRestaurantsFromYelp(currentLatitude: latitude, currentLongitude: longitude)
        }
//        }
//        else {
//            showGenericAlert(description: "No connectivity, please try again later.")
//        }
    }
    
    
    @IBAction func didTapHelpButton(_ sender: UIBarButtonItem) {
        if let instructionsVC = storyboard?.instantiateViewController(withIdentifier: "HelpVC") {
            present(instructionsVC, animated: true)
        }
    }
    
    @IBAction func didTapCenterOnUserLocationButton(_ sender: UIButton) {
        
        DispatchQueue.main.async {
//            let region = MKCoordinateRegion(center: self.currentLocation.coordinate, span: self.mapView.region.span)
//            self.mapView.setRegion(region, animated: true)
            self.updateMapView(self.distance, self.distance)
        }
    }
    
    // MARK: prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass data to RestaurantViewController
        if segue.identifier == "ChooseForMeSegue" {
            // Pass data
            if let restaurantViewController = segue.destination as? RestaurantViewController {
                // Choose random restaurant
                let randomRestaurant = self.restaurants.randomElement()
                restaurantViewController.restaurant = randomRestaurant
            }
        } else if segue.identifier == "SettingsSegue" {
            if let settingsVC = segue.destination as? SettingsViewController {
                settingsVC.distance = Float(distance)
                settingsVC.rating = Float(rating)
                settingsVC.price = price
            }
        }
    }
    
    // function called when VCs exit
    @IBAction func unwindMapViewVC(segue: UIStoryboardSegue) {
        if let settingsVC = segue.source as? SettingsViewController {
//            if NetworkMonitor.shared.isConnected {
            if let currentLocation = currentLocation {
                getRestaurantsFromYelp(
                    currentLatitude: currentLocation.coordinate.latitude,
                    currentLongitude: currentLocation.coordinate.longitude,
                    distance: Double(settingsVC.distance),
                    rating: Double(settingsVC.rating),
                    price: settingsVC.price
                )
            }
//            }
//            else {
//                showGenericAlert(description: "No connectivity, please try again later.")
//            }
        } else if let restaurantVC = segue.source as? RestaurantViewController {
            if restaurantVC.accepted {
                print("Accepted Restaurant")
            } else if restaurants.count > 1 {
                for index in 0..<restaurants.count {
                    if restaurants[index].name == restaurantVC.restaurant.name {
                        restaurants.remove(at: index)
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateMapView(self.distance, self.distance)
                    self.performSegue(withIdentifier: "ChooseForMeSegue", sender: nil)
                    
                }
            } else {
                // MARK: USER REJECTED ALL OPTIONS
                // you removed all your options, would you like to expand the radius
                // YOU ARE UNPLEASABLE!
                showAlert(title: "😱", message: """
                No more options!
                Change your settings for more options
                """, type: "outOfRestaurants"
                )
            }
            
        }
    }
    
    // open Settings
    func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
}

//MARK: - CLLocationManager Delegate Methods
extension MapViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            
            DispatchQueue.main.async {
                
                self.currentLocation = location
                
                // update region for map to track user's location
                self.updateMapView(self.distance, self.distance)
                self.updateRestaurants()
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // called when location auth is changed.
        DispatchQueue.main.async {
            
            if manager.authorizationStatus == .authorizedWhenInUse || manager.authorizationStatus == .authorizedAlways {
                manager.requestLocation()
            } else {
                self.showAlert(title: "Location Error", message: "Location needs to be allowed in Settings to choose a nearby restaurant for you.", type: "locationDenied")
            }
            
            if let location = manager.location {
                self.currentLocation = location
            }
            
            // update region for map to track user's location
            self.updateMapView(self.distance, self.distance)
            self.updateRestaurants()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }
    
}


//MARK: - mapView Delegate Methods
extension MapViewController : MKMapViewDelegate {}


// MARK: Fetch Restaurants
extension MapViewController {
    func getRestaurantsFromYelp(currentLatitude latitude: Double, currentLongitude longitude: Double, distance: Double = 0, rating: Double = 0, price: Int = 5) {

        // checks for network connection first and returns upon failure
//        guard(NetworkMonitor.shared.isConnected) else {
//            showGenericAlert(description: "There is currently no internet connection! Please try again later.")
//            return
//        }
        
        guard (latitude >= -90 && latitude <= 90) else {
            print("latitude must be between -90 and 90")
            return
        }
        
        guard (longitude >= -180 && longitude <= 180) else {
            print("latitude must be between -180 and 180")
            return
        }
        
        // Fetch restaurants from YelpAPI
        let yelpClient = YLPClient(apiKey: YELP_API_KEY)
        let yelpCoordinate = YLPCoordinate(latitude: latitude, longitude: longitude)
        let yelpQuery = YLPQuery(coordinate: yelpCoordinate)
        yelpQuery.categoryFilter = ["restaurants"] //this array can be used to let user select cuisine
        yelpQuery.radiusFilter = floor(Double(1600 * distance))
        yelpQuery.limit = 50
        var tempRestaurants = [Restaurant]()
        
        
        yelpClient.search(with: yelpQuery) { search, error in
            if let error = error {
                print("Could not complete search. Error: \(error)")
            } else {
                if let search = search {
                    for business in search.businesses {
                        var stAddress2 = ""
                        
                        // validate whether address has multiple lines
                        if business.location.address.count > 1 {
                            stAddress2 = business.location.address[1]
                        }
                        
                        // filter for restaurantes based on max dollar signs (price)
                        if business.price.count > price {
                            continue
                        }
                        
                        // filter for restaurantes based on min rating
                        if business.rating < rating {
                            continue
                        }
                        
                        tempRestaurants.append(Restaurant(
                            name: business.name,
                            image_url: business.imageURL,
                            is_closed: business.isClosed,
                            url: business.url,
                            categories: business.categories,
                            rating: business.rating,
                            latitude: business.location.coordinate!.latitude,
                            longitude: business.location.coordinate!.longitude,
                            price: business.price,
                            distance: business.distance,
                            display_phone: business.phone,
                            streetAddress1: business.location.address[0],
                            streetAddress2: stAddress2,
                            zipCode: business.location.postalCode,
                            city: business.location.city,
                            country: business.location.countryCode,
                            state: business.location.stateCode
                        ))
                    }
                }
            }
            
            self.restaurants = tempRestaurants
        }
        
        
    }
}


// MARK: ALERTS
extension MapViewController {
    func showAlert(title: String, message: String, type: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        switch type {
            case "locationDenied":
                let action = UIAlertAction(title: "Open Settings", style: .default) {_ in
                    self.openSettings()
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
                alertController.addAction(action)
                alertController.addAction(cancelAction)
                break
            case "outOfRestaurants":
                let action = UIAlertAction(title: "OK", style: .default) { action in
                    self.getRestaurantsFromYelp(
                        currentLatitude: self.currentLocation!.coordinate.latitude,
                        currentLongitude: self.currentLocation!.coordinate.longitude,
                        distance: self.distance,
                        rating: self.rating,
                        price: self.price
                    )
                    
                    DispatchQueue.main.async {
                        self.updateMapView(self.distance, self.distance) // this can be changed to use only one distance
                    }
                }
                alertController.addAction(action)
                break
            default:
                let action = UIAlertAction(title: title, style: .default)
                alertController.addAction(action)
                break
        }
            
        
       
        present(alertController, animated: true)
    }
}
