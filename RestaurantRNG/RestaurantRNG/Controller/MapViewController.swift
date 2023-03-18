//
//  ViewController.swift
//  RestaurantRNG
//
//  Created by Antonio Franceschi on 3/10/23.
//

import UIKit
import MapKit

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
    private var currentLocation : CLLocation = CLLocation(latitude: 25.7562, longitude: 80.3755)
    
    var restaurants = [Restaurant]() {
        didSet {
            updateMapView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        // set CLLocationManager delegate to self
        locationManager.delegate = self
        
        // one-time request for location, must be called after setting delegate
        locationManager.requestLocation()

        // set mapView delegate to self
        mapView.delegate = self
        
        // UI candy
        mapView.layer.cornerRadius = 12
        
        DispatchQueue.main.async {
            self.updateMapView()
        }
    }
    
    private func updateMapView() {
        
        // set mapView's region based on coordinates
        // span represents "zoom level", where a small value is more zoomed in
        // this should eventually be adjusted based on search radius selected by user
        let region = MKCoordinateRegion(center: currentLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: false)
        
        // "for each" loop that effectively adds a pin/annotation for each restaurant in array
        for restaurant in restaurants {
            let annotation = MKPointAnnotation()
            annotation.coordinate = restaurant.coordinate
            mapView.addAnnotation(annotation)
        }

    }
    
    private func updateRestaurants() {
        
        // this is probably where we should trigger API to retrieve data,
        // then update UI elements after successful pull
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
        }
    }
    
}

//MARK: - CLLocationManager Delegate Methods
extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            currentLocation = location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
            DispatchQueue.main.async {
                // self.updateRestaurants() // will probably just be able to just call this because it will call
                // updateMapView() itself
                self.updateMapView()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


//MARK: - mapView Delegate Methods
extension MapViewController : MKMapViewDelegate {
    
    
}

