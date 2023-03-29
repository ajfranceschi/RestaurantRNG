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
        Nuke.loadImage(with: restaurant.image_url!, into: restaurantImageView)
        restaurantNameLabel.text = restaurant.name
        let text:String = String(format: "%f", restaurant.rating)
        restaurantRatingLabel.text = text
        restaurantAddressLabel.text = restaurant.streetAddress1
        restuarantPhoneNumber.text = restaurant.display_phone
        restaurantPriceLabel.text = restaurant.price
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
