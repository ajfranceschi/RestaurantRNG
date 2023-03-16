//
//  ViewController.swift
//  RestaurantRNG
//
//  Created by Antonio Franceschi on 3/10/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var ratingSlider: UISlider!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var profileButton: UIBarButtonItem!
    @IBOutlet weak var prefsButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    // set current location to FIU campus until updated by device location
    private var currentLocation : CLLocation = CLLocation(latitude: 25.7562, longitude: 80.3755)
    
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
        mapView.setRegion(region, animated: true)
        
        // needs additional code for "pins" that represent user and restaurants
        let annotation = MKPointAnnotation()
        annotation.coordinate = currentLocation.coordinate
        mapView.addAnnotation(annotation)
    }

    override func viewWillAppear(_ animated: Bool) {
        // we can use this method if constant updating is desired and only track
        // when app is in focus
        //locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // we can use this method if constant updating is desired and
        // we want to turn off tracking when app isn't in focus to save battery
        //locationManager.stopUpdatingLocation()
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

