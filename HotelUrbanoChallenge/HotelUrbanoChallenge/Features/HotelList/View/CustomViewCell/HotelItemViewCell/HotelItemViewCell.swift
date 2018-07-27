//
//  HotelItemViewCell.swift
//  HotelUrbanoChallenge
//
//  Created by maciosdev on 26/07/2018.
//  Copyright © 2018 Ronilson. All rights reserved.
//

import UIKit
import AlamofireImage

class HotelItemViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var name: UILabel!
    @IBOutlet fileprivate weak var price: UILabel!
    @IBOutlet fileprivate weak var amenities: UILabel!
    @IBOutlet fileprivate weak var cityAndState: UILabel!
    @IBOutlet fileprivate weak var cellView: UIView!
    @IBOutlet fileprivate weak var imageHotel: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 10
        cellView.backgroundColor = UIColor.white
        cellView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cellView.layer.shadowColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1).cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowRadius = 5
    }
    
    func fillOutlets(hotel: HotelListViewModel.HotelItemViewModel) {
        
        self.cityAndState.text = "\(hotel.city ?? " ")/ \(hotel.state ?? " ")"
        self.name.text = hotel.name
        self.price.text = hotel.price?.formatedAsCurreny()

        
        if let imageString = hotel.image, let imageURL = URL(string: imageString) {
            imageHotel!.af_setImage(withURL: imageURL)
        }
    }
    
}
