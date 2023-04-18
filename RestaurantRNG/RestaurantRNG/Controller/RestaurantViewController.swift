//
//  RestaurantViewController.swift
//  RestaurantRNG
//
//  Created by Vincent Verapen on 3/22/23.
//

import UIKit
import Nuke
import SafariServices
import CoreLocation
import MapKit
class RestaurantViewController: UIViewController {
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var restaurantCityStateLabel: UILabel!
    @IBOutlet weak var restaurantPhoneNumber: UIButton!
    @IBOutlet weak var restaurantPriceLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantLinkButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var restaurant: Restaurant!
    var safariSvc: SFSafariViewController?
    var accepted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nuke, load image
        if let restaurantUrl = restaurant.image_url {
            ImagePipeline.shared.loadImage(with: restaurantUrl) { result in
                switch result {
                case.success(let res):
                    self.restaurantImageView.image = res.image
                    break
                case .failure(let error):
                    print("\n\n\(restaurantUrl)\n\(error.localizedDescription)")
                    self.restaurantImageView.image = UIImage(systemName: "photo")
                    break
                }
            }
        }
        
        // Restaurant Labels
        restaurantNameLabel.text = restaurant.name
        restaurantRatingLabel.text = String(format: "Rating: %.1f", restaurant.rating)
        restaurantAddressLabel.text = restaurant.streetAddress1
        restaurantCityStateLabel.text = "\(restaurant.city), \(restaurant.state)"
        
        if let phone = restaurant.display_phone {
            restaurantPhoneNumber.setTitle(phone.applyPatternOnNumbers(pattern: "+# (###) ###-####", replacementCharacter: "#"), for: .normal)
        }
                
        restaurantPriceLabel.text = restaurant.price
        
        let restaurantCategories = restaurant.categories.map { $0.name }
        categoryLabel.text = restaurantCategories.count > 1 ? "Categories:" : "Category:"
        restaurantCategoryLabel.text = restaurantCategories.joined(separator: ", ")
        
        safariSvc = SFSafariViewController(url: restaurant.url)
    }
    
    @IBAction func didTapRestaurantLink(_ sender: UIButton) {
        print("Tapped")
        if let safariSvc = safariSvc {
            safariSvc.modalPresentationStyle = .popover
            present(safariSvc, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapRejectButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapAcceptButton(_ sender: UIButton) {
        accepted = true
        self.dismiss(animated: true)
        openMapForPlace() // TODO: Maybe move this to the unwind in MapViewVC to reset the app.
    }
    
    @IBAction func didTapPhoneNumber(_ sender: UIButton) {
        guard let phone = restaurant.display_phone else { return }
        UIApplication.shared.open(URL(string: "tel://\(phone)")!)
    }
    
    
    
    func openMapForPlace() {
        
        let latitude:CLLocationDegrees =  restaurant.latitude
        let longitude:CLLocationDegrees =  restaurant.longitude
        
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: 3200, longitudinalMeters: 1600)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(restaurant.name)"
        mapItem.openInMaps(launchOptions: options)
        
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
