//
//  RestaurantViewController.swift
//  RestaurantRNG
//
//  Created by Vincent Verapen on 3/22/23.
//

import UIKit
import Nuke
import SafariServices

class RestaurantViewController: UIViewController {
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restuarantPhoneNumber: UILabel!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantLinkButton: UIButton!
    
    var restaurant: Restaurant!
    var safariSvc: SFSafariViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let restaurantUrl = restaurant.image_url{
            Nuke.loadImage(with: restaurantUrl, into: restaurantImageView)
        }
        restaurantNameLabel.text = restaurant.name
        restaurantRatingLabel.text = String(format: "%.1f", restaurant.rating)
        restaurantAddressLabel.text = restaurant.streetAddress1
        restuarantPhoneNumber.text = restaurant.display_phone?.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#")
        restaurantPriceLabel.text = restaurant.price
        
        safariSvc = SFSafariViewController(url: restaurant.url)
    }
    
    @IBAction func didTapButtonBack(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapRestaurantLink(_ sender: UIButton) {
        print("Tapped")
        if let safariSvc = safariSvc {
            safariSvc.modalPresentationStyle = .popover
            present(safariSvc, animated: true, completion: nil)
        }
    }
    
}

extension String {
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0..<pattern.count {
            guard index < pureNumber.count else {return pureNumber}
            
            let stringindex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringindex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringindex)
        }
        return pureNumber
    }
}