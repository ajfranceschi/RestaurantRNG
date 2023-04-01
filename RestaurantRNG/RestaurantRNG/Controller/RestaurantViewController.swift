//
//  RestaurantViewController.swift
//  RestaurantRNG
//
//  Created by Vincent Verapen on 3/22/23.
//

import UIKit
import Nuke
class RestaurantViewController: UIViewController {

    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantLinkLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restuarantPhoneNumber: UILabel!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let restaurantUrl = restaurant.image_url{
            Nuke.loadImage(with: restaurantUrl, into: restaurantImageView)
        }
        restaurantNameLabel.text = restaurant.name
        restaurantRatingLabel.text = String(format: "%.1f", restaurant.rating)
        restaurantAddressLabel.text = restaurant.streetAddress1
        restuarantPhoneNumber.text = restaurant.display_phone
        restaurantPriceLabel.text = restaurant.price
        restaurantLinkLabel.text =  String(describing: restaurant.url)
    }
    
    @IBAction func didTapButtonBack(_ sender: UIButton) {
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
