//
//  SettingsViewController.swift
//  RestaurantRNG
//
//  Created by Antonio Franceschi on 3/22/23.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var distanceSlider: UISlider!
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet weak var priceSlider: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var distance: Float = 5.0
    var rating: Float = 0.0
    var price: Int = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ratingSlider.setValue(rating, animated: true)
        
    }
    
    @IBAction func didChangeDistanceSliderValue(_ sender: UISlider) {
        distanceLabel.text = String(format: "%.1f mi", sender.value)
        distance = (String(format: "%.1f", sender.value) as NSString).floatValue
        
        // enable save btn
        saveButton.isEnabled = true
    }
    
    
    @IBAction func didChangeRatingSliderValue(_ sender: UISlider) {
        ratingLabel.text = String(format: "%.1f", sender.value)
        rating = (String(format: "%.1f", sender.value) as NSString).floatValue
        
        // enable save btn
        saveButton.isEnabled = true
    }
    
    @IBAction func didChangePriceSliderValue(_ sender: UISlider) {
        price = Int(floor(sender.value))
        var priceString = ""
        for _ in 1...price {
            priceString = priceString + "$"
        }
        
        priceLabel.text = priceString
        
        saveButton.isEnabled = true
    }
    
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didPressCancelButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("performing SettingsVC Segue")
        let mapViewVC = segue.destination as? MapViewController
        
        if let mapViewVC = mapViewVC {
            mapViewVC.distance = Double(distance)
            mapViewVC.rating = Double(rating)
            mapViewVC.price = price
        }
    }

}
