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
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var radiusLabel: UILabel!
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var prefsButton: UIBarButtonItem!
    
    private let locationManager = CLLocationManager()
    // set current location to FIU campus until updated by device location
    private var currentLocation : CLLocation = CLLocation(latitude: 25.7562, longitude: -80.3755)
    
    var restaurants = [Restaurant]() {
        didSet {
            DispatchQueue.main.async {
                self.updateMapView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if locationManager.authorizationStatus == .denied {
            // Show alert to go to settings with message advising that app doesn't work without location and to enable in settings.
        }
        
        locationManager.requestWhenInUseAuthorization()
        
        // set CLLocationManager delegate to self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // one-time request for location, must be called after setting delegate
        locationManager.requestLocation()

        // set mapView delegate to self
        mapView.delegate = self
        
        // UI candy
        mapView.layer.cornerRadius = 12
        
        // Remove default POIs
        let mapConfiguration = MKStandardMapConfiguration()
        mapConfiguration.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
        mapView.isUserInteractionEnabled = false // disable interaction with map
        mapView.preferredConfiguration = mapConfiguration
        
        
        DispatchQueue.main.async {
            self.updateMapView()
            self.updateRestaurants()
        }
    }
    
    private func updateMapView() {
        
        // set mapView's region based on coordinates
        // span represents "zoom level", where a small value is more zoomed in
        // this should eventually be adjusted based on search radius selected by user
        let region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: false)
                
        // "for each" loop that effectively adds a pin/annotation for each restaurant in array
        if restaurants.count != 0 {
            for restaurant in restaurants {
                if (!restaurant.is_closed) {
                    let annotation = MKPointAnnotation()
                    annotation.title = restaurant.price
                    annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
                    mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    private func updateRestaurants() {
        
        // this is probably where we should trigger API to retrieve data,
        // then update UI elements after successful pull
        
        // MARK: Declare a constant named YELP_API_KEY in /RestaurantRNG/Env/EnvVars.swift (must create structure for your project)
        // Get restaurants on a 1 mile radius from user location
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        getRestaurantsFromYelp(latitude: latitude, longitude: longitude)
       
    }
    
    
    

    @IBAction func ratingSliderUpdated(_ sender: UISlider) {
        let newRating = Int(round(ratingSlider.value))
        
        DispatchQueue.main.async {
            self.ratingLabel.text = "\(newRating) Stars"
        }
    }
    
    
    @IBAction func radiusSliderUpdated(_ sender: UISlider) {
        let formattedRadius = String(format: "%.1f mi", radiusSlider.value)
        DispatchQueue.main.async {
            self.radiusLabel.text = formattedRadius
            
            // should eventually change region shown on map and updateMapView()
            // TODO: This should be added to the settings VC
        }
    }
    
    @IBAction func didTapProfileButton(_ sender: UIBarButtonItem) {
        print("Button Pressed")
    }
    
}

//MARK: - CLLocationManager Delegate Methods
extension MapViewController : CLLocationManagerDelegate {
    
    // MARK: this function does not get called unless the locationManager.startUpdatingLocation() is called.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            DispatchQueue.main.async {
                // self.updateRestaurants() // will probably just be able to just call this because it will call
                // updateMapView() itself
//                self.updateMapView()
                
                // Update currentLocation
                self.currentLocation = location
                
                // update region for map to track user's location
                self.mapView.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }
    
}


//MARK: - mapView Delegate Methods
extension MapViewController : MKMapViewDelegate {
    
    
}


// MARK: Fetch Restaurants
extension MapViewController {
    func getRestaurantsFromYelp(latitude: Double, longitude: Double){
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
        yelpQuery.categoryFilter = ["restaurants"]
        yelpQuery.radiusFilter = Double(1600 * radiusSlider.value)
        yelpQuery.limit = 20
        var tempRestaurants = [Restaurant]()

        
        yelpClient.search(with: yelpQuery) { search, error in
            if let error = error {
                print("Could not complete search. Error: \(error)")
            } else {
                if let search = search {
                    for business in search.businesses {
                        var stAddress2 = ""
                        if business.location.address.count > 1 {
                            stAddress2 = business.location.address[1]
                        }
                        tempRestaurants.append(Restaurant(
                            name: business.name,
                            image_url: business.imageURL,
                            is_closed: business.isClosed,
                            url: business.url, category: business.categories[0].name,
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
                            state: business.location.stateCode))
                    }
                }
            }
            
            self.restaurants = tempRestaurants
//            for restaurant in self.restaurants {
//                restaurant.toString()
//            }
        }
        
        
    }
}

