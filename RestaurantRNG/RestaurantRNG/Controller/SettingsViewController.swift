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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didChangeDistanceSliderValue(_ sender: UISlider) {
        
    }
    
    
    @IBAction func didChangeRatingSliderValue(_ sender: UISlider) {
    }
    
    @IBAction func didChangePriceSliderValue(_ sender: UISlider) {
    }
    
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
