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
    
    private var locationManager : CLLocationManager?
    private var currentLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //locationManager = CLLocationManager()
        // set CLLocationManager delegate to self
        //locationManager.delegate = self

        // set mapView delegate to self
        mapView.delegate = self
        
        // UI candy
        mapView.layer.cornerRadius = 12
        
        // updateMap()

    }

    override func viewWillAppear(_ animated: Bool) {
        
        //locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        //locationManager.stopUpdatingLocation()
    }
    

}

//MARK: - CLLocationManager Delegate Methods
extension MapViewController : CLLocationManagerDelegate {
    
    
}


//MARK: - mapView Delegate Methods
extension MapViewController : MKMapViewDelegate {
    
    
}

